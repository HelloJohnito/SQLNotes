-- SELECT
SELECT columns
FROM table_name;


-- DISTINCT: Unique column values
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

-- Count of distinct columns
SELECT COUNT(DISTINCT(column))
FROM table_name;
-- example
  -- 2006, 2006, 2007, 2007 will return 2006, 2007. The count is 2


-- LIMIT: limits the number of row
SELECT *
FROM table_name
LIMIT 5; -- goes at the end


-- ORDER BY: ASC/DESC
SELECT column
FROM table_name
ORDER BY column ASC;

-- ORDERS first name then orders the result by the lastname if they have the same first name.
SELECT firstname, lastname
FROM table_name
ORDER BY firstname ASC, lastname DESC;


-- BETWEEN
SELECT column
FROM table_name
WHERE column BETWEEN 1 AND 4;

SELECT column
FROM table_name
WHERE column NOT BETWEEN 1 AND 4;


-- IN : you can subquery
SELECT column1, column2
FROM table_name
WHERE column1 IN (1,2) -- you can also do NOT IN ()
ORDER BY column2 DESC;


-- LIKE: pattern matching
SELECT column
FROM table_name
WHERE column LIKE 'Jen%';
-- returns column values with a Jen at the beginning

SELECT column
FROM table_name
WHERE column LIKE '%y';
-- returns column values with a y at the end

SELECT column
FROM table_name
WHERE column LIKE '%er%';
-- returns column values with a er somewhere in the same
-- beginning, middle, end

SELECT column
FROM table_name
WHERE column LIKE 'apple_';
-- use underscore for one character

SELECT column
FROM table_name
WHERE column LIKE '_the%'; -- other


-- MIN MAX AVG SUM
SELECT ROUND(AVG(column), 2)
FROM table_name;


-- GROUP BY
SELECT name
FROM table_name
GROUP BY name
-- this is same as SELECT DISTINCT(column)

SELECT name, SUM(amount)
FROM table_name
GROUP BY name
ORDER BY SUM(amount) DESC;
-- SELECTS name and gets the sum of the amount for each name
-- Then orders the amount


-- HAVING: occurs after group by where as WHERE occurs before the columns are grouped.
SELECT column1, SUM(column2)
FROM table_name
GROUP BY column1
HAVING SUM(column2) > 200;

-- AS
SELECT column1, SUM(column2) AS new_name
FROM table_name



-- Join

SELECT table_a.column1, table_b.column2
FROM table_a
JOIN table_b ON table_b.id = table_a.id
WHERE first LIKE 'A%'

  -- Inner Join: Returns rows in A table that have the corresponding rows in the b table. Available to both sides.

  -- Full Outer Join: Produces the set of all records in table A and table b. if there is no match the missing side will contain null.

  -- Full Outer Join with WHERE a is null or b is null: selects everything expect the ones in common.
    SELECT * FROM table_a
    FULL OUTER JOIN table_b
    ON table_a.name = table_b.name
    WHERE table_a.name IS NULL OR table_b.name IS NULL

  -- Left Outer Join: Produces a complete set of records from table A with the matching records (where available) in table B. If there is no match, the right side will contain null.

  -- Left Outer Join with WHERE B is NUll: Produces the set of records only in Table A but not in Table B
    SELECT * FROM table_a
    LEFT OUTER JOIN table_b
    ON table_a.name = table_b.name
    WHERE table_b.name IS null

  -- Right Outer Join: Produces a complete set of records from table B with the matching records (where available) in table A. If there is no match, the right side will contain null.

  -- Right Outer Join with WHERE A is Null: Produces the set of records only in Table B but not in Table A



-- UNION: operator combines result sets of two or more select statements into a single result set. UNION combines and deletes duplicate rows
-- UNION ALL will not delete duplicate

SELECT column1, column2
FROM table_1
UNION
SELECT column_1, column_2
FROM table_2
