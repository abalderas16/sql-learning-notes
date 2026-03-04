
---Six Popular categories of data types in SQL 
--Numeric = INTEGER, FLOAT, SERIAL, DECIMAL 
--Date = TIMESTAMP, DATE, TIME 
--Character = CHAR, VARCHAR, TEXT 
--Unicode = NTEXT, NVARCHAR
--Binary = non-textual data like images, audio, video files
--Miscellaneous data = XML, TABLE 

--PostgreSQL Data Types
units_sold INTEGER --Consume 4 bytes range
units_sold SMALLINT -- smaller range of numbers 
units_sold BIGINT --bigger range of numbers 
id SERIAL -- creating unique identifier 
customer_name VARCHAR(50) -- this can set the max character length within parenthese VARCHAR(n)
vendor_address TEXT -- this sets a maximum lenght for the string 
event_date DATE -- stores date 
start_time TIME -- stores time 
event_timestamp TIMESTAMP --stores date & time 
event_timestamp TIMESTAMP WITH TIME ZONE -- stores date, time and includes time zone
is_active BOOLEAN -- stores a boolean value TRUR or FALSE  