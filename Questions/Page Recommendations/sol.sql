
with friend AS (
SELECT
    IF(user1_id<user2_id, user1_id, user2_id) AS user1_id,
    IF(user1_id<user2_id, user2_id, user1_id) AS user2_id
FROM friendship)

SELECT DISTINCT page_id
FROM friend f
JOIN likes l ON f.user2_id = l.user_id
WHERE f.user1_id = 1 AND page_id NOT IN (SELECT page_id FROM likes WHERE user_id = 1)