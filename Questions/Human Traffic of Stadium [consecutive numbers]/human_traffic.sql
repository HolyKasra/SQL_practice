with cte AS (
    select
        id, 
        visit_date,
        people,
        id - row_number() over() AS marker
    from stadium
    where people>=100
)

select id, visit_date, people
from cte
where marker IN (select marker from cte group by marker having COUNT(marker)>=3)