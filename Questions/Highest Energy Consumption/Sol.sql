with tbl AS (
    select *
    from fb_eu_energy
    UNION ALL
    select *
    from fb_asia_energy
    UNION ALL
    select *
    from fb_na_energy
),

consumers AS (
	select 
		date,
		SUM(consumption) AS total,
		dense_rank() over(order by SUM(consumption) DESC) AS ranking
	from tbl
	group by date
)

select 
    date, 
    total
from consumers
where ranking = 1
