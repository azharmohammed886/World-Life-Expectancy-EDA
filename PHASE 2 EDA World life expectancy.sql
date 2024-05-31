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


