select 
    language,
    COUNT(DISTINCT case when device IN ("macbook pro", "iphone 5s","ipad air") then pe.user_id end) AS n_apple_user,
    COUNT(distinct pe.user_id) AS n_total_users


from playbook_events pe
join playbook_users pu using (user_id)
group by pu.language
order by n_total_users DESC