create database HR;
USE HR;

-- Total Number of Employees
SELECT COUNT(*) AS Total_Employees
from hr_analytics;

-- Display All Employees
SELECT *
FROM hr_analytics;

-- Find All Distinct Departments
SELECT DISTINCT Department
FROM hr_analytics;

-- Count Employees by Department
SELECT Department,
COUNT(*) AS Employee_Count
from hr_analytics
GROUP BY Department
order by Employee_Count desc;

-- Count Employees by Gender
SELECT Gender,
COUNT(*) AS Employee_Count
FROM hr_analytics
GROUP BY Gender;

-- Find Average Monthly Income
SELECT ROUND(AVG(MonthlyIncome),2) AS Average_Salary
FROM hr_analytics;

-- Highest and Lowest Monthly Income
SELECT MAX(MonthlyIncome) AS Highest_Salary,
       MIN(MonthlyIncome) AS Lowest_Salary
FROM hr_analytics;

ALTER TABLE hr_analytics
RENAME COLUMN ï»¿Age TO Age;

-- Average Age of Employees
SELECT ROUND(AVG(Age), 2) AS Average_Age
FROM hr_analytics;

-- Employees Working Overtime
SELECT EmployeeNumber,JobRole,Department,OverTime
FROM hr_analytics
WHERE OverTime = 'Yes';

-- Count Employees with Attrition
SELECT Attrition,
       COUNT(*) AS Employee_Count
FROM hr_analytics
GROUP BY Attrition;

-- Department-Wise Attrition
SELECT Department,
       COUNT(*) AS Attrition_Count
FROM hr_analytics
WHERE Attrition = 'Yes'
GROUP BY Department
ORDER BY Attrition_Count desc;

-- Job Role-wise Employee Count
SELECT JobRole,
       COUNT(*) AS Employee_Count
FROM hr_analytics
GROUP BY JobRole
ORDER BY Employee_Count desc;

-- Average Salary by Department
SELECT Department,
       ROUND(AVG(MonthlyIncome),2) AS Average_Salary
FROM hr_analytics
GROUP BY Department
ORDER BY Average_Salary desc;

-- Average Salary by Job Role
SELECT JobRole,
       ROUND(AVG(MonthlyIncome),2) AS Average_Salary
FROM hr_analytics
GROUP BY JobRole
ORDER BY Average_Salary desc;

-- Overtime vs Attrition
SELECT OverTime,
       Attrition,
	   COUNT(*) AS Employee_Count
FROM hr_analytics
GROUP BY OverTime,Attrition
ORDER BY OverTime;

-- Employee by Marital Status
SELECT MaritalStatus,
       COUNT(*) AS Employee_Count
FROM hr_analytics
GROUP BY MaritalStatus
ORDER BY EmployEE_Count DESC;

-- Average Years at Company by Department
SELECT Department,
       ROUND(AVG(YearsAtCompany),2) as Avg_Years
FROM hr_analytics
GROUP BY Department
Order by Avg_Years DESC;

-- Employees with More Than 10 Years at Company
SELECT EmployeeNumber,
       JobRole,
       Department,
       YearsAtCompany
FROM hr_analytics
WHERE YearsAtCompany > 10
ORDER BY YearsAtCompany DESC;

-- Avearge Job Satisfaction by Department
SELECT Department,
       ROUND(AVG(JobSatisfaction),2) AS Avg_Job_Satisfaction
FROM hr_analytics
GROUP BY Department
ORDER BY Avg_Job_Satisfaction desc;

-- Top 10 Highest Paid Employees
SELECT EmployeeNumber,
       JobRole,
       Department,
       MonthlyIncome
FROM hr_analytics
ORDER BY MonthlyIncome DESC
LIMIT 10;

-- Employee Earning Above Average Salary
SELECT EmployeeNumber,
	   JobRole,
       Department,
       MonthlyIncome
FROM hr_analytics
WHERE MonthlyIncome >
(
	   SELECT AVG(MonthlyIncome)
       FROM hr_analytics
)
ORDER BY MonthlyIncome DESC;

-- Department Having More Than 200 Employees
SELECT Department,
       COUNT(*) AS Employee_Count
FROM hr_analytics
GROUP BY Department
HAVING COUNT(*) > 200;

-- Attrition Count by Education Field
SELECT EducationField,
       COUNT(*) AS Attrition_Count
FROM hr_analytics
WHERE Attrition = 'Yes'
GROUP BY EducationField
ORDER BY Attrition_Count DESC;

-- Salary Category Using CASE
SELECT EmployeeNumber,
       MonthlyIncome,
       CASE
           WHEN MonthlyIncome < 5000 THEN 'Low Salary'
           WHEN MonthlyIncome BETWEEN 5000 AND  10000 THEN 'Medium_Salary'
           ELSE 'High Salary'
		END AS Salary_Category
	from hr_analytics;
    
    -- Age Group Analysis
    SELECT
    CASE
        WHEN Age < 30 Then 'Under 30'
        WHEN Age BETWEEN 30 AND 40 THEN '30-40'
        WHEN Age BETWEEN 41 AND 50 THEN '41-50'
        ELSE 'Above 50'
	END AS Age_Group,
    COUNT(*) AS Employees
    FROM hr_analytics
    GROUP BY Age_Group
    Order by Employees DESC;
    
    -- Average Salary by Gender
    SELECT Gender,
           ROUND(AVG(MonthlyIncome),2) AS Average_Salary
	FROM hr_analytics
    GROUP BY Gender;
    
    -- Employee with High Job Satisfaction
    SELECT EmployeeNumber,
           JobRole,
           Department,
           JobSatisfaction
	FROM hr_analytics
    WHERE JobSatisfaction = 4;
    
    -- Department-wise Average Performance Rating
    SELECT Department,
           ROUND(AVG(PerformanceRating),2) AS Avg_Performance
	FROM hr_analytics
    GROUP BY Department
    ORDER BY Avg_Performance desc;
    
-- Employees Who Have Never Been Promoted
SELECT EmployeeNumber,
	   JobRole,
	   YearsSinceLastPromotion
FROM hr_analytics
WHERE YearsSinceLastPromotion = 0;
    
-- Rank E mployees by Salary
SELECT EmployeeNumber,
       JobRole,
       Department,
       MonthlyIncome,
       RANK() OVER(ORDER BY MonthlyIncome DESC) AS Salary_Rank
from hr_analytics;

-- Dense Rank Employees by Salary
SELECT EmployeeNumber,
       JobRole,
       Department,
       MonthlyIncome,
       DENSE_RANK() OVER(ORDER BY MonthlyIncome DESC) AS Salary_Rank
FROM hr_analytics;

-- Row Number by Department
SELECT EmployeeNumber,
       Department,
       JobRole,
       ROW_NUMBER() OVER(PARTITION BY Department ORDER BY MonthlyIncome DESC) AS ROW_Num
FROM hr_analytics;

-- Top 3 Highest Paid Employees in Each Department
SELECT *
FROM (
    SELECT EmployeeNumber,
           Department,
           JobRole,
           MonthlyIncome,
           DENSE_RANK() OVER(
               PARTITION BY Department
               ORDER BY MonthlyIncome DESC
           ) AS Salary_Rank
    FROM hr_analytics
) AS ranked
WHERE Salary_Rank <= 3;

-- Average Salary of Each Department
SELECT EmployeeNumber,
       Department,
       MonthlyIncome,
       ROUND(AVG(MonthlyIncome) OVER(PARTITION BY Department),2) AS Department_Avg_Salary
FROM hr_analytics;



