
WITH n_box AS (
    SELECT SUM(apple_count) AS apple_count, SUM(orange_count) AS orange_count
    FROM boxes
),
    n_chest AS (
        SELECT SUM(c.apple_count) AS apple_count, SUM(c.orange_count) AS orange_count
        FROM chests c
        JOIN boxes b ON c.chest_id = b.chest_id
)

SELECT c.apple_count + b.apple_count AS apple_count, c.orange_count + b.orange_count AS orange_count
FROM n_chest c, n_box b