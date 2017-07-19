-- Write a query to find the difference between the total number of cities and the unique number of cities in the table STATION.

SELECT COUNT(city) - COUNT(DISTINCT(CITY))
FROM station;

-- Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.

SELECT DISTINCT(city)
FROM station
WHERE city LIKE '%a' OR city LIKE '%e' OR city LIKE '%i' OR city LIKE '%o' OR city LIKE '%u';



-- Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.

SELECT DISTINCT(city)
FROM station
WHERE (city LIKE 'a%' OR city LIKE 'e%' OR city LIKE 'i%' OR city LIKE 'o%' OR city LIKE 'u%') AND (city LIKE '%a' OR city LIKE '%e' OR city LIKE '%i' OR city LIKE '%o' OR city LIKE '%u');

SELECT DISTINCT(city)
FROM station
WHERE right(city,1) IN ('A', 'E', 'I', 'O', 'U') AND left(city,1) IN ('A', 'E', 'I', 'O', 'U');

-- Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.

SELECT DISTINCT(city) FROM station
WHERE left(city,1) NOT IN ('A', 'E', 'I', 'O', 'U');


-- Query the Name of any student in STUDENTS who scored higher than  Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.

SELECT name FROM students
WHERE marks > 75
ORDER BY right(name,3), id;

-- Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater $2000 than per month who have been employees for less than  months. Sort your result by ascending employee_id.

SELECT name FROM employee
WHERE salary > 2000 AND months < 10;


-- Query the average population of all cities in CITY where District is California.

SELECT AVG(population) FROM city
WHERE district = 'California'
GROUP BY district;

-- Query the difference between the maximum and minimum populations in CITY.
SELECT MAX(population) - MIN(population)
FROM city;


-- Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, but did not realize her keyboard's 0 key was broken until after completing the calculation. She wants your help finding the difference between her miscalculation (using salaries with any zeroes removed), and the actual average salary.

SELECT CEIL(AVG(salary) - AVG(REPLACE(salary,'0','')))
FROM employees;


-- We define an employee's total earnings to be their monthly salaryxMonth worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as 2 space-separated integers.

SELECT salary*months AS earnings, count(*)
FROM employee
GROUP BY earnings DESC
LIMIT 1;


-- Query the Western Longitude (LONG_W) for the smallest Northern Latitude (LAT_N) in STATION that is greater than 38.7780. Round your answer to  decimal places.

SELECT ROUND(long_w, 4) FROM station
WHERE lat_n = (SELECT MIN(lat_n) FROM station WHERE lat_n > 38.7780);

SELECT ROUND(long_w, 4) FROM station
WHERE lat_n > 38.7780
ORDER BY lat_n
LIMIT 1;


-- Consider (a,b) and (c,d) to be two points on a 2D plane.
-- a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
-- b happens to equal the minimum value in Western Longitude (LONG_W in STATION).
-- c happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
-- d happens to equal the maximum value in Western Longitude (LONG_W in STATION).
-- Query the Manhattan Distance between points  and  and round it to a scale of  decimal places.

SELECT ROUND(ABS(MIN(lat_n) - MAX(lat_n)) + ABS(MIN(long_w) -  MAX(long_w)),4)
FROM station;


-- A median is defined as a number separating the higher half of a data set from the lower half. Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to 4 decimal places.

SELECT round(S.LAT_N,4)
FROM station S
WHERE (
    SELECT count(Lat_N)
    FROM station
    WHERE Lat_N < S.LAT_N ) = (
        SELECT count(Lat_N)
        FROM station
        WHERE Lat_N > S.LAT_N);



-- Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.
-- Note: CITY.CountryCode and COUNTRY.Code are matching key columns.

SELECT city.name
FROM city
JOIN country
    ON country.code = city.countrycode
WHERE continent = 'Africa' ;


-- Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.

SELECT country.continent, ROUND(AVG(city.population)-0.5)
FROM country
JOIN city
    ON city.countrycode = country.code
GROUP BY country.continent;


-- Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. Ketty doesn't want the NAMES of those students who received a grade lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first. If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.

SELECT if(grades.grade < 8, null, students.name), grades.grade, students.marks
FROM students
JOIN grades
    ON students.marks BETWEEN grades.min_mark AND grades.max_mark
ORDER BY grades.grade DESC, students.name;



-- Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. Order your output in descending order by the total number of challenges in which the hacker earned a full score. If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.

SELECT hackers.hacker_id, hackers.name
FROM hackers
JOIN submissions
    ON submissions.hacker_id = hackers.hacker_id
JOIN challenges
    ON challenges.challenge_id = submissions.challenge_id
JOIN difficulty
    ON difficulty.difficulty_level = challenges.difficulty_level

WHERE submissions.score = difficulty.score AND challenges.difficulty_level = difficulty.difficulty_level

GROUP BY hackers.name, hackers.hacker_id
HAVING COUNT(submissions.hacker_id) > 1
ORDER BY COUNT(submissions.hacker_id) DESC, submissions.hacker_id ASC;


-- Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.
--
-- Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age. Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. If more than one wand has same power, sort the result in order of descending age.

SELECT w1.id, wp1.age, w1.coins_needed, w1.power
FROM wands AS w1
JOIN wands_property AS wp1
    ON w1.code = wp1.code
WHERE wp1.is_evil = 0
    AND w1.coins_needed = (SELECT MIN(w2.coins_needed)
                              FROM wands AS w2
                              JOIN wands_property AS wp2
                                ON w2.code = wp2.code
                              WHERE wp1.age = wp2.age AND w1.power = w2.power )

ORDER BY w1.power DESC, wp1.age DESC;
