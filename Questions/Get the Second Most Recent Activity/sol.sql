
with cte AS (
    SELECT
        username, activity, startDate, endDate,
        RANK() OVER (PARTITION BY username ORDER BY startDate DESC) AS rnk
    FROM useractivity
)

SELECT username, activity, startDate, endDate
FROM cte
WHERE rnk = 2 OR username IN (SELECT username FROM cte GROUP BY username HAVING COUNT(*)=1)