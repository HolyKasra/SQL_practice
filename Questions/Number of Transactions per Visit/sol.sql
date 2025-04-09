
WITH RECURSIVE cnt AS (
    SELECT
        v.user_id,
        v.visit_date,
        COUNT(t.user_id) AS transaction_count
    FROM visits v
    LEFT JOIN transactions t
        ON v.user_id = t.user_id AND v.visit_date = t.transaction_date
    GROUP BY v.user_id, v.visit_date
),

indices AS (
    SELECT 0 AS transaction_count
    UNION ALL
    SELECT transaction_count + 1
    FROM indices
    WHERE transaction_count < (SELECT MAX(transaction_count) FROM cnt)
)

SELECT
    transaction_count,
    IFNULL(SUM(IF(user_id IS NOT NULL,1, NULL)),0) AS total_count
FROM indices i
LEFT JOIN cnt c USING (transaction_count)
GROUP BY transaction_count