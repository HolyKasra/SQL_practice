WITH RECURSIVE idx AS (
    SELECT 1 as rnk
    UNION ALL
    SELECT rnk + 1 FROM idx WHERE rnk <3
),
    tbl AS (
    SELECT
        country,
        CONCAT(winery,' (',SUM(points) ,')') AS winery ,
        SUM(points) AS points,
        dense_rank() OVER (PARTITION BY country ORDER BY SUM(points) DESC , winery) AS rnk
    FROM sessions
    GROUP BY country, winery
)
SELECT  t.country,
        (SELECT winery FROM tbl WHERE rnk = 1 AND country = t.country)
            AS top_winery,

        IFNULL(
            (SELECT winery FROM tbl WHERE rnk = 2 AND country = t.country),'No second winery')
            AS second_winery,

        IFNULL(
            (SELECT winery FROM tbl WHERE rnk = 3 AND country = t.country),'No third winery')
            AS third_winery

FROM tbl t
GROUP BY country