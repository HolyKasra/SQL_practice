
SELECT student_id
FROM students s
JOIN enrollments e USING (student_id)
JOIN courses c USING (course_id)
GROUP BY student_id
HAVING
   AVG(credits * GPA) >= 2.5
   AND SUM(IF(mandatory='yes' AND grade='A', 1, 0)) = SUM(IF(mandatory='yes', 1, 0))
   AND SUM(IF(mandatory='no' AND grade IN ('A','B'), 1, 0)) = SUM(IF(mandatory='no', 1, 0))
   AND SUM(IF(mandatory='no', 1, 0)) >= 2