-- SELECT
SELECT columns
FROM table_name;

-- DISTINCT: Unique
SELECT DISTINCT columns
FROM table_name;

-- WHERE
SELECT column
FROM table_name
WHERE column = 'word';
  -- Operations are =,<,>, <=, >=, !=, AND, OR

-- COUNT
SELECT COUNT(column)
FROM table_name;

SELECT COUNT(DISTINCT(column))
FROM table_name;
