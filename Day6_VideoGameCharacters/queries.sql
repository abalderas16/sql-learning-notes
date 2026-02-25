/*
Day 6 – SQL Mini Project
Video Game Characters Relational Database

Demonstrated Skills:
- Relational modeling (PK/FK)
- INNER vs LEFT JOIN
- Aggregations (COUNT, AVG, SUM)
- CTEs (WITH clauses)
- Window functions (RANK, OVER, PARTITION)
- Analytical percentage calculations
*/
-- Query 1: Character dimension view (JOIN across core entities)

SELECT
    c.character_id,
    c.name                AS character_name,
    g.title               AS game_title,
    g.genre               AS game_genre,
    cl.class_name         AS character_class,
    c.level,
    c.hp,
    c.mp,
    CASE 
        WHEN c.is_playable = 1 THEN 'Playable'
        ELSE 'NPC'
    END                   AS character_type
FROM characters AS c
INNER JOIN games     AS g  ON c.game_id  = g.game_id
INNER JOIN classes   AS cl ON c.class_id = cl.class_id
ORDER BY 
    g.title ASC,
    c.level DESC;

---Query 2

SELECT name, level, hp, mp
FROM characters
WHERE is_playable = 1
ORDER BY level DESC;

-- Query 3: Character distribution per game with percentage of total

WITH game_counts AS (
    SELECT
        g.title,
        COUNT(*) AS character_count
    FROM games g
    JOIN characters c ON c.game_id = g.game_id
    GROUP BY g.title
)

SELECT
    title,
    character_count,
    ROUND(
        100.0 * character_count / SUM(character_count) OVER (),
        2
    ) AS percent_of_total
FROM game_counts
ORDER BY character_count DESC;

---Query 4

SELECT
  c.name AS character_name,
  i.item_name,
  i.item_type,
  ci.quantity
FROM character_items ci
JOIN characters c ON ci.character_id = c.character_id
JOIN items i ON ci.item_id = i.item_id
ORDER BY c.name, i.item_type;

-- Query 5: Total inventory power per character with ranking

WITH power_calc AS (
    SELECT
        c.name AS character_name,
        COALESCE(SUM(i.power * ci.quantity), 0) AS total_item_power
    FROM characters c
    LEFT JOIN character_items ci 
        ON c.character_id = ci.character_id
    LEFT JOIN items i 
        ON ci.item_id = i.item_id
    GROUP BY c.name
)

SELECT
    character_name,
    total_item_power,
    RANK() OVER (ORDER BY total_item_power DESC) AS power_rank
FROM power_calc
ORDER BY power_rank;

---Query 6

/*(JOIN + WHERE + GROUP BY)*/
SELECT
  g.title AS game_title,
  COUNT(*) AS playable_characters
FROM games g
JOIN characters c ON c.game_id = g.game_id
WHERE c.is_playable = 1
GROUP BY g.title
ORDER BY playable_characters DESC;

---Query 7

/*(AVG + ROUND)*/
SELECT
  g.title AS game_title,
  ROUND(AVG(c.level), 1) AS avg_playable_level
FROM games g
JOIN characters c ON c.game_id = g.game_id
WHERE c.is_playable = 1
GROUP BY g.title
ORDER BY avg_playable_level DESC;

---Query 8

SELECT
  c.name AS character_name,
  COUNT(ci.item_id) AS unique_items
FROM characters c
LEFT JOIN character_items ci ON c.character_id = ci.character_id
GROUP BY c.name
HAVING COUNT(ci.item_id) >= 2
ORDER BY unique_items DESC;

-- Query 9: Highest level character per game

WITH ranked_characters AS (
    SELECT
        g.title AS game_title,
        c.name  AS character_name,
        c.level,
        RANK() OVER (
            PARTITION BY g.title
            ORDER BY c.level DESC
        ) AS level_rank
    FROM characters c
    JOIN games g ON c.game_id = g.game_id
)

SELECT
    game_title,
    character_name,
    level
FROM ranked_characters
WHERE level_rank = 1;
