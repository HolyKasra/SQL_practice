SELECT
    request_at AS Day,
    ROUND(COUNT(CASE WHEN status <> 'completed' THEN status END)/COUNT(*),2) AS `Cancellation Rate`
FROM trips
WHERE
    client_id NOT IN (SELECT users_id FROM users WHERE banned = 'Yes') AND
    driver_id NOT IN (SELECT users_id FROM users WHERE banned = 'Yes') AND
    request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY request_at