WITH cte AS (SELECT Id,
                    Company,
                    Salary,
                    ROW_NUMBER() OVER (PARTITION BY Company ORDER BY Salary) AS rownum,
                    COUNT(Id) OVER (PARTITION BY Company) AS n
             FROM salaries)

SELECT ID, Company, Salary
FROM cte
WHERE rownum BETWEEN n/2 AND n/2 + 1
ORDER BY Company, Salary
