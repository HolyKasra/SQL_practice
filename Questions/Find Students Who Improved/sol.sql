WITH cte AS (
    SELECT
        student_id, subject, exam_date,
        FIRST_VALUE(score) OVER (PARTITION BY student_id, subject ORDER BY exam_date) AS first_score,
        LAST_VALUE(score) OVER (PARTITION BY student_id, subject ORDER BY exam_date) AS latest_score,
        ROW_NUMBER() OVER (PARTITION BY student_id, subject ORDER BY exam_date DESC) AS row_num
    FROM scores
    ORDER BY student_id, subject, exam_date DESC
)
SELECT *
FROM cte
WHERE row_num = 1 AND first_score < latest_score