select DISTINCT at1.user_id
from amazon_transactions at1
join amazon_transactions at2
on at1.user_id = at2.user_id
AND at1.id <> at2.id
AND DATEDIFF(at2.created_at, at1.created_at) BETWEEN 0 AND 7