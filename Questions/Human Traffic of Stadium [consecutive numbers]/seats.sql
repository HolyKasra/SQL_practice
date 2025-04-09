
with cte AS (SELECT *,
       seat_id - row_number() OVER () AS idx
FROM cinema
WHERE free <> 0
)

SELECT seat_id
FROM cte
WHERE idx IN (SELECT idx FROM cte GROUP BY idx HAVING count(*)>=3)