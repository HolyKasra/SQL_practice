WITH index_table AS (
    SELECT DISTINCT product_id
    FROM products
)
SELECT
    product_id,
    -- below subquery must return exactly one row
    -- correlative subqueries are processed row by row
    -- LIMIT 1 is used to return exactly one row or one value to be exact
    -- IF_NULL is the final tep to satisfy the problem's condition
    IFNULL((SELECT new_price
     FROM products
     WHERE product_id = it.product_id AND change_date<='2019-08-16'
     ORDER BY change_date DESC
     LIMIT 1 ), 10) AS price
FROM index_table it