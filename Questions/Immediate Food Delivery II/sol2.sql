WITH cte AS (
                SELECT
                    order_date,
                    customer_pref_delivery_date,
                    RANK() OVER (PARTITION BY customer_id ORDER BY order_date) AS ranking
                FROM delivery
)

SELECT
    ROUND(AVG(IF(order_date = customer_pref_delivery_date,1,0))*100,2) AS immediate_percentage
FROM cte
WHERE ranking = 1
