-- link: https://leetcode.com/problems/immediate-food-delivery-ii/description/?envType=study-plan-v2&envId=top-sql-50
SELECT
    ROUND(AVG(IF(order_date = customer_pref_delivery_date, 1, 0))*100,2) AS immediate_percentage
FROM delivery
WHERE (customer_id, order_date) IN (
    SELECT customer_id, MIN(order_date)
    FROM delivery
    GROUP BY customer_id
)