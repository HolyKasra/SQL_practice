WITH RECURSIVE hierarchy AS (

    SELECT employee_id, employee_name, 0 AS level, salary
    FROM employees e2
    WHERE manager_id IS NULL
	
    UNION ALL
	
    SELECT 
		e.employee_id, 
		e.employee_name, 
		level +1 AS level, 
		e.salary - (SELECT salary FROM employees WHERE manager_id IS NULL)
    FROM hierarchy h
    JOIN employees e ON e.manager_id = h.employee_id
)

SELECT *
FROM hierarchy
WHERE level>0