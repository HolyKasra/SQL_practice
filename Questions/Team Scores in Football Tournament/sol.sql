WITH scores AS (
    SELECT
        *,
        (CASE
            WHEN host_goals < guest_goals THEN 0
            WHEN host_goals = guest_goals THEN 1
            ELSE 3
        END) AS host_score,
        IF((SELECT host_score)<> 1, 3- (SELECT host_score), 1) AS guest_score
    FROM matches
),
    score_update AS (
    SELECT host_team AS team_id, host_score AS num_points
    FROM scores
    UNION ALL
    SELECT guest_team, guest_score
    FROM scores
)

SELECT
    t.team_id,
    t.team_name,
    COALESCE((SELECT SUM(num_points) FROM score_update WHERE t.team_id = team_id),0) AS num_points
FROM teams t
ORDER BY num_points DESC