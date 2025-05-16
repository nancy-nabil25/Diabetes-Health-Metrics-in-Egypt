## year with the highest and lowest diabetes prevalence.

(SELECT Year, `AgeStd_Diabetes_18+` AS Prevalence, 'Highest' AS Type
 FROM `cleaned_diabetes (1)`
 ORDER BY `AgeStd_Diabetes_18+` DESC
 LIMIT 1)

UNION ALL

(SELECT Year, `AgeStd_Diabetes_18+` AS Prevalence, 'Lowest' AS Type
 FROM `cleaned_diabetes (1)`
 ORDER BY `AgeStd_Diabetes_18+` ASC
 LIMIT 1);
 
 ##Compare treatment rates over the years.
SELECT Year, 
       AVG(`Crude_Treated_30+`) AS Avg_Treatment_Rate
FROM `cleaned_diabetes (1)`
GROUP BY Year
ORDER BY Year;

##4. Check if treatment rates increase when prevalence is higher.
      SELECT Year, 
       AVG(`Crude_Diabetes_18+`) AS Avg_Diabetes_Prevalence,
       AVG(`Crude_Treated_30+`) AS Avg_Treatment_Rate
FROM `cleaned_diabetes (1)`
GROUP BY Year
ORDER BY Year;
## دا لكل السنين 
SELECT 
    (COUNT(*) * SUM(`Crude_Diabetes_18+` * `Crude_Treated_30+`) - 
     SUM(`Crude_Diabetes_18+`) * SUM(`Crude_Treated_30+`)) 
    / 
    (SQRT((COUNT(*) * SUM(POW(`Crude_Diabetes_18+`, 2)) - POW(SUM(`Crude_Diabetes_18+`), 2)) * 
          (COUNT(*) * SUM(POW(`Crude_Treated_30+`, 2)) - POW(SUM(`Crude_Treated_30+`), 2)))
    ) AS Correlation_Coefficient
FROM `cleaned_diabetes (1)`;
 ## دا على سحب راجل ولا ست 
 SELECT Sex,
    (COUNT(*) * SUM(`Crude_Diabetes_18+` * `Crude_Treated_30+`) - 
     SUM(`Crude_Diabetes_18+`) * SUM(`Crude_Treated_30+`)) 
    / 
    (SQRT((COUNT(*) * SUM(POW(`Crude_Diabetes_18+`, 2)) - POW(SUM(`Crude_Diabetes_18+`), 2)) * 
          (COUNT(*) * SUM(POW(`Crude_Treated_30+`, 2)) - POW(SUM(`Crude_Treated_30+`), 2)))
    ) AS Correlation_Coefficient
FROM `cleaned_diabetes (1)`
GROUP BY Sex;
 
 ## Predict future diabetes prevalence based on past trends.

 SELECT Year, 
       AVG(`Crude_Diabetes_18+`) OVER (ORDER BY Year ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS Moving_Avg_Prediction
FROM `cleaned_diabetes (1)`
ORDER BY Year;