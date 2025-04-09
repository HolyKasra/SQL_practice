SELECT
    user_id AS buyer_id ,
    join_date,
    (
        SELECT COUNT(order_id)
        FROM orders
        WHERE YEAR(order_date) = 2019 AND buyer_id = u.user_id
        ) AS orders_in_2019
FROM users u;


Category -> identify number of occurrence even if it is zero using ifnull technique!

Similar with : PRODUCT PRICE AT A GIVEN DATE 
LINK: https://leetcode.com/problems/product-price-at-a-given-date/description/?envType=study-plan-v2&envId=top-sql-50

WITH p1 AS (
            SELECT DISTINCT product_id
            FROM products)
SELECT
    p1.product_id,
    IFNULL(
            (SELECT new_price
             FROM products p2
             WHERE p1.product_id = p2.product_id AND p2.change_date<='2019-08-16'
             ORDER BY p2.change_date DESC
             LIMIT 1)
    ,10) AS price

FROM p1;