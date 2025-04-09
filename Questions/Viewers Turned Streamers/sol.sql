WITH cte AS (
    SELECT
        user_id,
        session_start,
        session_type,
        RANK() OVER (PARTITION BY user_id ORDER BY session_start) AS rnk
    FROM sessions
),
    users AS (
    SELECT user_id
    FROM cte
    WHERE rnk = 1 AND session_type = 'viewer'
)

SELECT user_id, SUM(IF(session_type='streamer', 1, 0)) AS session_count
FROM sessions
WHERE user_id IN (SELECT * FROM users)
GROUP BY user_id
HAVING session_count>0;