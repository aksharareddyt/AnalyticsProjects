/* Driver Analysis
1. Which nationalities have more drivers?alter
*/
SELECT
    nationality,
    COUNT(*) AS total_drivers
FROM drivers
GROUP BY nationality
ORDER BY total_drivers DESC;

-- 2. Top 10 countries by number of drivers
SELECT
    nationality,
    COUNT(*) AS total_drivers
FROM drivers
GROUP BY nationality
ORDER BY total_drivers DESC
LIMIT 10;

-- 3. Oldest driver in the database
SELECT
    forename,
    surname,
    dob
FROM drivers
ORDER BY dob
LIMIT 1;

-- 4. Youngest driver in the list
SELECT
    forename,
    surname,
    dob
FROM drivers
ORDER BY dob DESC
LIMIT 1;

/* Circuit Analysis
1. Circuits by country */
SELECT
    country,
    COUNT(*) AS circuits
FROM circuits
GROUP BY country
ORDER BY circuits DESC;

-- 2. Countries with exactly one circuit
SELECT
    country,
    COUNT(*) AS circuits
FROM circuits
GROUP BY country
HAVING COUNT(*) = 1;

/* Constructor Analysis
1. COnstructors by nationality */
SELECT
    nationality,
    COUNT(*) AS constructors
FROM constructors
GROUP BY nationality
ORDER BY constructors DESC;

/* Race Analysis
1. Number of races per season */
SELECT
    year,
    COUNT(*) AS races
FROM races
GROUP BY year
ORDER BY year;

-- 2. Which season had most races?
SELECT
    year,
    COUNT(*) AS races
FROM races
GROUP BY year
ORDER BY races DESC
LIMIT 1;

-- 3. Average races per season
SELECT
    ROUND(AVG(races),2) AS average_races
FROM
(
	SELECT
        year,
        COUNT(*) AS races
    FROM races
    GROUP BY year
) t;

/* Results 
1. Average points awarded per season */
SELECT
    ROUND(AVG(points),2) AS average_points
FROM results;

-- 2. Highest points scored in one race
SELECT
    MAX(points) AS highest_points
FROM results;

 -- 3. Total championship points awarded
 SELECT
    SUM(points) AS total_points
FROM results;

-- 4. Average finishing position
SELECT
    ROUND(AVG(positionOrder),2) AS average_finish
FROM results;

-- 5. Number of classified race results
SELECT COUNT(*) AS total_results
FROM results;