WITH tbl AS (SELECT
    LEFT(pay_date,7) AS pay_month,
    department_id,
    amount
FROM employee e
LEFT JOIN salary s USING (employee_id))

SELECT
    pay_month,
    department_id,
    (CASE
        WHEN AVG(amount) = (SELECT AVG(amount) FROM tbl WHERE pay_month = t.pay_month)  THEN 'same'
        WHEN AVG(amount) > (SELECT AVG(amount) FROM tbl WHERE pay_month = t.pay_month) THEN 'higher'
        ELSE 'lower'
    END) AS comparison

FROM tbl t
GROUP BY pay_month, department_id
ORDER BY pay_month DESC, department_id