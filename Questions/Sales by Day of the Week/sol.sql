WITH sale AS (
SELECT
    DAYOFWEEK(order_date) AS dow,
    item_category,
    o.quantity
FROM items i
LEFT JOIN orders o
    ON o.item_id = i.item_id)

SELECT
    item_category,
    SUM(IF(dow=2, quantity, 0)) AS Monday,
    SUM(IF(dow=3, quantity, 0)) AS Tuesday,
    SUM(IF(dow=4, quantity, 0)) AS Wednesday,
    SUM(IF(dow=5, quantity, 0)) AS Thursday,
    SUM(IF(dow=6, quantity, 0)) AS Friday,
    SUM(IF(dow=7, quantity, 0)) AS Saturday,
    SUM(IF(dow=1, quantity, 0)) AS Sunday
FROM sale
GROUP BY item_category
ORDER BY item_category