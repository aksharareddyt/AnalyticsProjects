-- Total races
SELECT COUNT(*) AS Total_Races
FROM races;

-- Total drivers
SELECT COUNT(*) AS Total_Drivers
FROM drivers;

-- Total constructors
SELECT COUNT(*) AS Total_Constructors
FROM constructors;

-- British drivers
SELECT forename, surname
FROM drivers
WHERE nationality='British';