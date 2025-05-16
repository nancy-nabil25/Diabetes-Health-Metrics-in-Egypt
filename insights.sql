##ex1:How has the age-standardized prevalence of diabetes (AgeStd_Diabetes_18+) in Egypt changed from 1990 to 2022, and what are the differences between men and women??

select year, sex,`AgeStd_Diabetes_18+` as diabetes_prevalence
from cleaned_diabetes
where country = 'Egypt'
order by year and Sex;

##ex2:What are the differences in diabetes prevalence (AgeStd_Diabetes_18+) and treatment rates (AgeStd_Treated_30+) between men and women in Egypt from 1990 to 2022?

SELECT Year, Sex, `AgeStd_Diabetes_18+`, `AgeStd_Treated_30+`
FROM cleaned_diabetes
WHERE Year BETWEEN 1990 AND 2022
ORDER BY Year, Sex;

##ex3:What proportion of people with diabetes in Egypt remain untreated, and how has this proportion changed from 2000 to 2021?

SELECT Year, Sex, `AgeStd_Diabetes_18+`, `AgeStd_Treated_30+`, 
(1 - (`AgeStd_Treated_30+` / `AgeStd_Diabetes_18+`)) * 100 AS Untreated_Percentage 
FROM cleaned_diabetes
WHERE Year BETWEEN 2000 AND 2021
ORDER BY Year, Sex;

##ex4:How has the uncertainty in diabetes prevalence estimates (AgeStd_Diabetes_18+) changed over time in Egypt, and are there significant differences between men and women?

SELECT Year, Sex, `AgeStd_Diabetes_18+`,`AgeStd_Diab_L95_18+` AS Lower_Bound, 
`AgeStd_Diab_L95_v2_18+` AS Upper_Bound, 
(`AgeStd_Diab_L95_v2_18+` - `AgeStd_Diab_L95_18+`) AS Uncertainty_Range 
FROM cleaned_diabetes
WHERE Year BETWEEN 1990 AND 2022 
ORDER BY Year, Sex;

##ex5:How do crude diabetes prevalence rates (Crude_Diabetes_18+) compare to age-standardized rates (AgeStd_Diabetes_18+) in Egypt from 1990 to 2022?

SELECT Year, `AgeStd_Diabetes_18+`, `Crude_Diabetes_18+`, 
(`AgeStd_Diabetes_18+` - `Crude_Diabetes_18+`) AS Difference 
FROM cleaned_diabetes
WHERE Year BETWEEN 1990 AND 2022
ORDER BY Year;

##ex6:What percentage of people with diabetes in Egypt receive treatment (AgeStd_Treated_30+), and how has this percentage changed from 1990 to 2022?

SELECT Year, (`AgeStd_Treated_30+` / `AgeStd_Diabetes_18+`) * 100 AS Treatment_Percentage 
FROM Cleaned_Diabetes 
WHERE Year BETWEEN 1990 AND 2022
ORDER BY Year;
