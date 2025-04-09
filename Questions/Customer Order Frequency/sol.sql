
with tbl AS (SELECT
    c.name,
    SUM(CASE WHEN MONTH(order_date)=6 THEN o.quantity *  p.price END ) AS june_spent,
    SUM(CASE WHEN MONTH(order_date)=7 THEN o.quantity *  p.price END ) AS july_spent
FROM customers c
JOIN orders o USING (customer_id)
JOIN product p USING (product_id)
GROUP BY c.name
HAVING july_spent>=100 AND june_spent>=100)

SELECT name
FROM tbl