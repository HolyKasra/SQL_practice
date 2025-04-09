

with cte AS (select
    user_id,
    DATE(timestamp) AS date,
    MAX(case when action = 'page_load' then timestamp end) AS latest_load,
    MIN(case when action = 'page_exit' then timestamp end) AS earliest_exit
from facebook_web_log
group by user_id, DATE(timestamp)
having earliest_exit is not null)

select
    user_id,
    AVG(TIMESTAMPDIFF(second, latest_load, earliest_exit)) AS session_duration
from cte
where earliest_exit > latest_load
group by user_id