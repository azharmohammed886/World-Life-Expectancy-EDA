# 1.Deleting duplicates
 SELECT Country, Year, CONCAT(country, year) AS CountryANDyear, COUNT(CONCAT(country, year)) 
 FROM world_life_expectancy
 GROUP BY Country, Year, CountryANDyear
 HAVING COUNT(CountryANDyear) > 1 ;
 
 SELECT *
 FROM 
 (
 SELECT row_id, 
 CONCAT(country, year),
 row_number() OVER(PARTITION BY CONCAT(country, year) 
 ORDER BY CONCAT(country, year)) AS row_num
 FROM world_life_expectancy 
 )
 AS row_table
 WHERE row_num > 1;
 
 DELETE FROM world_life_expectancy
 WHERE
	row_ID IN (
    SELECT row_id
	FROM 
		(
		SELECT row_id, 
		CONCAT(country, year),
		row_number() OVER(PARTITION BY CONCAT(country, year) 
		ORDER BY CONCAT(country, year)) AS row_num
		FROM world_life_expectancy 
		)
	AS row_table
	WHERE row_num > 1
 );
 
  # 2.Adding the missing values
 SELECT *
 FROM world_life_expectancy;
 
 SELECT DISTINCT(status)
 FROM world_life_expectancy_project.world_life_expectancy
 WHERE status <> '';
 
 SELECT DISTINCT(country)
 FROM world_life_expectancy
 WHERE status = 'developing';
 
 UPDATE world_life_expectancy
 SET status = 'developing'
  WHERE country IN (
   SELECT DISTINCT(country)
 FROM world_life_expectancy
 WHERE status = 'developing'
 )
 ;
 
 UPDATE world_life_expectancy t1
 JOIN world_life_expectancy t2
	ON t1.country = t2.country
SET t1.status = 'Developing'
WHERE t1.status = ''
AND t2.status <> ''
AND t2.status = 'Developing'
;

SELECT *
FROM world_life_expectancy
WHERE Country = 'United States of America'
;

 UPDATE world_life_expectancy t1
 JOIN world_life_expectancy t2
	ON t1.country = t2.country
SET t1.status = 'Developed'
WHERE t1.status = ''
AND t2.status <> ''
AND t2.status = 'Developed'
;

 # 3. Filling the missing values using SELF JOIN
SELECT *
FROM world_life_expectancy
WHERE `Life expectancy` = '';


SELECT Country, Year, `Life expectancy`
FROM world_life_expectancy
WHERE `Life expectancy` = '';

SELECT t1.Country, t1.Year, t1.`Life expectancy`, 
		t2.Country, t2.Year, t2.`Life expectancy`,
			t3.Country, t3.Year, t3.`Life expectancy`,
	ROUND ((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country 
	AND t1.Year = t2.Year - 1
    JOIN world_life_expectancy t3
	ON t1.Country = t3.Country 
	AND t1.Year = t3.Year + 1
    WHERE t1.`Life expectancy` = '';
    
    
    UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country 
	AND t1.Year = t2.Year - 1
    JOIN world_life_expectancy t3
	ON t1.Country = t3.Country 
	AND t1.Year = t3.Year + 1
    SET t1.`Life expectancy` = ROUND ((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
    WHERE t1.`Life expectancy` = '';

 
  
 

 
 
 
 
 
 
    
 
 
