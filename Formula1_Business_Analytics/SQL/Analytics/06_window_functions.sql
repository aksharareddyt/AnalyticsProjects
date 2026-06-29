USE Formula1Analytics;
-- 1. Rank drivers by career points
SELECT
    d.forename,
    d.surname,
    SUM(r.points) AS career_points,

    RANK() OVER(
        ORDER BY SUM(r.points) DESC
    ) AS ranking

FROM results r

JOIN drivers d
ON r.driverId=d.driverId

GROUP BY
d.driverId,
d.forename,
d.surname;

-- 2. Dense rank
SELECT
    d.forename,
    d.surname,
    SUM(r.points) AS career_points,

    DENSE_RANK() OVER(
        ORDER BY SUM(r.points) DESC
    ) AS ranking

FROM results r

JOIN drivers d
ON r.driverId=d.driverId

GROUP BY
d.driverId,
d.forename,
d.surname;

-- 3. Row number
SELECT
    d.forename,
    d.surname,

    SUM(r.points) AS career_points,

    ROW_NUMBER() OVER(
        ORDER BY SUM(r.points) DESC
    ) AS `row_number`

FROM results r

JOIN drivers d
ON r.driverId=d.driverId

GROUP BY
d.driverId,
d.forename,
d.surname;

-- 4. Ranking drivers inside each nationality
SELECT
    d.nationality,
    d.forename,
    d.surname,
    SUM(r.points) AS career_points,

    RANK() OVER(
        PARTITION BY d.nationality
        ORDER BY SUM(r.points) DESC

    ) AS national_rank

FROM results r

JOIN drivers d

ON r.driverId=d.driverId

GROUP BY
d.driverId,
d.forename,
d.surname,
d.nationality;

-- 5. Running total of races by season
SELECT

year,

COUNT(*) AS races,

SUM(COUNT(*))

OVER(

ORDER BY year

)

AS cumulative_races

FROM races

GROUP BY year;

-- 6. Previous season race count
SELECT

year,

COUNT(*) AS races,

LAG(COUNT(*))

OVER(

ORDER BY year

)

AS previous_year

FROM races

GROUP BY year; 

-- 7. Difference from previous race
SELECT

year,

COUNT(*) AS races,

COUNT(*)-

LAG(COUNT(*))

OVER(

ORDER BY year

)

AS change_from_last_year

FROM races

GROUP BY year;

-- 8. Next season race count
SELECT

year,

COUNT(*) AS races,

LEAD(COUNT(*))

OVER(

ORDER BY year

)

AS next_year

FROM races

GROUP BY year;

-- 9. Top constrcutor each nationality
SELECT

nationality,

name,

RANK()

OVER(

PARTITION BY nationality

ORDER BY constructorId

)

AS ranking

FROM constructors;

-- 10. Top 10 drivers by career points
SELECT *

FROM

(

SELECT

d.forename,

d.surname,

SUM(r.points) AS career_points,

RANK()

OVER(

ORDER BY SUM(r.points) DESC

)

AS ranking

FROM results r

JOIN drivers d

ON r.driverId=d.driverId

GROUP BY

d.driverId,

d.forename,

d.surname

)x

WHERE ranking<=10;