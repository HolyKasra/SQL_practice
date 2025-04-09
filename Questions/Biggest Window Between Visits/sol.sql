
with cte AS (
    SELECT user_id, visit_date, LEAD(visit_date,1,'2021-01-01') OVER w  AS lead_date
    FROM uservisits
    WINDOW w AS (PARTITION BY user_id ORDER BY visit_date)
)

SELECT user_id, MAX(ABS(DATEDIFF(visit_date, lead_date))) AS biggest_window
FROM cte
GROUP BY user_id