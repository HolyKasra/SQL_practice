
WITH paid AS  (SELECT paid_by, -amount AS paid_amount FROM transaction),
     received AS ( SELECT paid_to , amount AS received_amount FROM transaction)

SELECT
    user_id,
    user_name,
    credit + IFNULL(paid_amount,0) + IFNULL(received_amount, 0) AS credit,
    IF(credit + IFNULL(paid_amount,0) + IFNULL(received_amount, 0)<0, 'Yes', 'No') AS credit_limit_breached
FROM users u
LEFT JOIN paid p
    ON p.paid_by = u.user_id
LEFT JOIN received r
    ON r.paid_to = u.user_id