WITH RECURSIVE datevals AS (
        SELECT (SELECT MIN(purchases.purchase_date) FROM purchases) AS purchase_date
        UNION ALL
        SELECT ADDDATE(purchase_date, 1) FROM datevals
        WHERE purchase_date <= LAST_DAY((SELECT MAX(purchase_date) FROM purchases))

),
    startdate AS (
        SELECT MIN(purchase_date) AS purchase_date
        FROM purchases
        WHERE DAYNAME(purchase_date) = 'Friday'
),
    fridays AS (
        SELECT purchase_date FROM startdate
        UNION ALL
        SELECT ADDDATE(purchase_date,7) AS purchase_date
        FROM fridays
        WHERE ADDDATE(purchase_date,7) <= LAST_DAY((SELECT MAX(purchase_date) FROM purchases))
    )

SELECT f.purchase_date, IFNULL(SUM(amount_spend), 0) AS total_amount
FROM fridays f
LEFT JOIN purchases p USING (purchase_date)
GROUP BY f.purchase_date