
-----Engineer Mindset: Show me metrics not rows
-----Drill 1: Orders per vendor----
 SELECT vendor_name, 
    COUNT(*) AS total_orders
FROM raw_orders
GROUP BY vendor_name
ORDER BY total_orders DESC; 

---Think: Which vendors handle the most volume? 

--Real world Data:
SELECT
  VAH.SERVICE_NAME AS vendor_name,
  COUNT(DISTINCT VAH.ORDER_ID) AS total_orders
FROM SPLUS.NJ_ENTERPRISE_VENDOR_ASSIGNMENT_HISTORY VAH
JOIN SPLUS.NJ_ENTERPRISE_ORDERS O
  ON O.ORDER_ID = VAH.ORDER_ID
WHERE VAH.SERVICE_NAME IS NOT NULL
  AND O.ORDER_DTM >= '2025-01-01'
  AND O.ORDER_DTM <  '2027-01-01'
GROUP BY VAH.SERVICE_NAME
ORDER BY total_orders DESC;
----Above captures the data for Vendors handled volumne for 2025 to 2026


-----Drill 2: Revenue per Vendor----
SELECT vendor_name,
    SUM(total_amount) AS total_revenue
FROM raw_orders
GROUP BY vendor_name
ORDER BY total_revenue DESC; 

----Top revenue vendors = contract leverage

---Real World Data: 
SELECT 
	VC.SERVICE_NAME AS vendor_name, 
	SUM(VC.ACTUAL_COST) AS total_actual_cost,
	COUNT(DISTINCT VC.ORDER_ID) AS total_orders,
	SUM(VC.ACTUAL_COST) * 1.0/ NULLIF(COUNT(DISTINCT VC.ORDER_ID), 0) AS avg_cost_per_order
FROM SPLUS.NJ_ENTERPRISE_VENDOR_COST AS VC
WHERE VC.SERVICE_NAME IS NOT NULL
GROUP BY VC.SERVICE_NAME
ORDER BY total_actual_cost DESC;
-----Above captures the data for all Vendors Total cost, total orders and AVG cost per Vendor per Order. 

------Drill 3: Avg Miles per Lane-----
SELECT lane, 
    AVG(miles) AS avg_miles
FROM raw_orders
GROUP BY lane;
----Which lanes are inefficient? 

---Real World Data:

---Real World Data: 
---Top 10 Lane orders by average miles / Orders with over 20
WITH lane_per_order AS (
  SELECT
    CONCAT(CORIG.PROVINCE_CD, ' - ', CDEST.PROVINCE_CD) AS lane,
    TRY_CAST(O.BILLING_DROPOFF_MILEAGE AS FLOAT) AS miles
  FROM SPLUS.NJ_ENTERPRISE_ORDERS O
  JOIN SPLUS.NJ_ENTERPRISE_CONTACT CORIG
    ON O.ORIGIN_CONTACT_ID = CORIG.CONTACT_ID
  JOIN SPLUS.NJ_ENTERPRISE_CONTACT CDEST
    ON O.DEST_CONTACT_ID = CDEST.CONTACT_ID
  WHERE CORIG.COUNTRY_CD = 'US'
    AND CDEST.COUNTRY_CD = 'US'
    AND CORIG.PROVINCE_CD IS NOT NULL
    AND CDEST.PROVINCE_CD IS NOT NULL
    AND O.ORDER_DTM >= '2025-01-01'
    AND O.ORDER_DTM <  '2027-01-01'
    AND TRY_CAST(O.BILLING_DROPOFF_MILEAGE AS FLOAT) IS NOT NULL
)
SELECT TOP 10
  lane,
  COUNT(*) AS orders,
  AVG(miles) AS avg_miles
FROM lane_per_order
GROUP BY lane
HAVING COUNT(*) >= 20
ORDER BY AVG(miles) DESC, COUNT(*) DESC;

------Drill 4: Daily Order Volume-----
SELECT order_date
    COUNT(*) AS orders_per_day
FROM raw_orders
GROUP BY order_date
ORDER BY order_date;

-----How many orders are generated daily? 

---Real World Data:
---“How many orders did we have each day between 2025–2026?”
SELECT
    CAST(O.ORDER_DTM AS DATE) AS order_date,--CAST removes time protion 
    COUNT(*) AS orders_per_day 
FROM SPLUS.NJ_ENTERPRISE_ORDERS O
WHERE O.ORDER_DTM >= '2025-01-01'
  AND O.ORDER_DTM <  '2027-01-01'
GROUP BY CAST(O.ORDER_DTM AS DATE)
ORDER BY order_date ASC;

---WEEKENDING Version: 
SELECT
  DATEADD(DAY,
          (3 - DATEPART(WEEKDAY, O.ORDER_DTM) + 7) % 7,
          CAST(O.ORDER_DTM AS DATE)
  ) AS week_ending,
  COUNT(*) AS orders_per_week
FROM SPLUS.NJ_ENTERPRISE_ORDERS O
WHERE O.ORDER_DTM >= '2025-01-01'
  AND O.ORDER_DTM <  '2027-01-01'
GROUP BY
  DATEADD(DAY,
          (3 - DATEPART(WEEKDAY, O.ORDER_DTM) + 7) % 7,
          CAST(O.ORDER_DTM AS DATE)
  )
ORDER BY week_ending;


------Drill 5: Vendor Performance Combo
SELECT vendor_name,
    COUNT(*) AS orders, 
    SUM(total_amount) AS revenue, 
    AVG(miles) as avg_miles
FROM raw_orders
GROUP BY vendor_name

---- What is the Vendor performance? 