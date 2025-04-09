

with tbl AS (
SELECT
    a.account_id,
    a.max_income,
    t.type,
    t.amount,
    MONTH(t.day) AS `month`

FROM accounts a
LEFT JOIN transactions t
    ON t.account_id = a.account_id
),
    income_tbl AS (SELECT
    account_id,
    month,
    max_income,
    SUM(CASE WHEN type = 'Creditor' THEN amount END) AS income
FROM tbl
GROUP BY account_id, month, max_income
ORDER BY account_id, month)


# SELECT i.account_id
SELECT DISTINCT i.account_id
FROM income_tbl i
JOIN income_tbl it
    ON i.account_id = it.account_id
           AND i.month + 1 = it.month
           AND i.income > i.max_income
           AND it.income> it.max_income