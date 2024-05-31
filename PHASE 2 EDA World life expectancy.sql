#World Life Expectancy EDA    PHASE 2 


SELECT *
FROM world_life_expectancy;

# 1. INSIGHT ON Life_expectancy_over_15years USING MAX AND MIN FUNCTION
SELECT Country, MAX(`Life expectancy`), 
				MIN(`Life expectancy`),
            ROUND (MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Life_expectancy_over_15years
FROM world_life_expectancy
GROUP BY Country
HAVING MAX(`Life expectancy`) <> 0 AND MIN(`Life expectancy`) <> 0
ORDER BY MAX(`Life expectancy`) and
				MIN(`Life expectancy`) DESC
;

# 2. INSIGHT ON LIFE_EXPECTANCY BY YEAR AND AVERAGE
 SELECT Year, ROUND(AVG(`Life expectancy`),2) AS AVG_Life_Expectancy
 FROM world_life_expectancy
WHERE (`Life expectancy`) <> 0 AND(`Life expectancy`) <> 0
 GROUP BY Year
 ORDER By Year DESC;
 
 
 SELECT *
FROM world_life_expectancy
ORDER BY GDP;

 #3. Correlation of Life exp and Avg gdp
SELECT Country,
ROUND(AVG(`Life expectancy`),1) 
AS AVG_LIFE_EXPECTANCY,
ROUND(AVG(GDP),1) AS AVG_GDP
FROM world_life_expectancy
GROUP BY Country
HAVING AVG_LIFE_EXPECTANCY > 0 AND AVG_GDP > 0;



# 4. Labelling low and high gdp correlated to Life exp
SELECT 
SUM(CASE WHEN GDP >= 1200 THEN 1 ELSE 0 END) AS HIGH_GDP,
AVG(CASE WHEN GDP >= 1200 
THEN `Life expectancy` ELSE NULL END) AS 
HIGH_GDP_LIFE_EXPECTANCY,
SUM(CASE WHEN GDP <= 1200 THEN 1 ELSE 0 END) 
AS LOW_GDP,
AVG(CASE WHEN GDP <= 1200 
THEN `Life expectancy` ELSE NULL END) 
AS LOW_GDP_LIFE_EXPECTANCY
FROM world_life_expectancy;

 
# 5. AVG life expectancy based on status 'developed' and 'developing

SELECT status,
ROUND
(AVG(`Life expectancy`), 1) AS AVG_LIFE_EXPECTANCY
FROM world_life_expectancy
GROUP BY status;


# 6. BMI against country 
SELECT Country,
ROUND
(AVG(BMI), 1) AS AVG_BMI
FROM world_life_expectancy
GROUP BY Country
HAVING AVG_BMI > 0 
ORDER BY AVG_BMI
;
