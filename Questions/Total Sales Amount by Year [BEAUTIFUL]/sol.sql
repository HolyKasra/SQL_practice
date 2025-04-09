#
# Explanation:
# (period_start) |<----------------------->| (period_end)
#                    '[year]-01-01' |<----------------->| '[year]-12-31'
#
#     number_of_days -> LEAST(period_end, '[year]-12-31') - GREATEST(period_start, '[year]-01-01') + 1
#
# if the value become negative,
# it means that year(period_start)> [year] -> it means the year is not available for that product
# e.g: start = 2019, end = 2020
# calculating for 2018 -> value = DATEDIFF('2018-12-31', start) < 0 since start is at least 2019!


WITH date AS (
    SELECT product_id, '2018' AS year,
           DATEDIFF(LEAST(period_end, '2018-12-31'), GREATEST(period_start, '2018-01-01')) + 1 AS duration
    FROM sales

    UNION ALL

    SELECT product_id, '2019' AS year,
           DATEDIFF(LEAST(period_end, '2019-12-31'), GREATEST(period_start, '2019-01-01')) + 1 AS duration
    FROM sales

    UNION ALL

    SELECT product_id, '2020' AS year,
           DATEDIFF(LEAST(period_end, '2020-12-31'), GREATEST(period_start, '2020-01-01')) + 1 AS duration
    FROM sales
)

SELECT product_id, product_name, year AS report_year, duration * average_daily_sales AS total_amount
FROM date
JOIN product USING (product_id)
JOIN sales USING (product_id)
WHERE duration IS NOT NULL AND duration * average_daily_sales > 0
ORDER BY product_id, report_year