
WITH cte AS (
    SELECT MIN(score) AS min, MAX(score) AS max
    FROM exam
)
SELECT DISTINCT e.student_id, s.student_name
FROM exam e
JOIN student s USING (student_id)
WHERE e.student_id NOT IN (SELECT student_id FROM exam WHERE score = (SELECT max FROM cte))
  AND e.student_id NOT IN (SELECT student_id FROM exam WHERE score = (select min FROM cte))
