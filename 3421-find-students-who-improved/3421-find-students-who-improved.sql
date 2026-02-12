-- Write your PostgreSQL query statement below
WITH ranked AS (
    SELECT 
    student_id,
    subject,
    score,
    exam_date,

    ROW_NUMBER() OVER (
        PARTITION BY student_id, subject
        ORDER BY exam_date ASC
    ) AS first_rank,

    ROW_NUMBER() OVER (
        PARTITION BY student_id, subject
        ORDER BY exam_date DESC
    ) AS last_rank,

    COUNT(*) OVER (
        PARTITION BY student_id, subject
    ) AS exam_count
 FROM Scores
)

SELECT 
student_id,
subject,
MAX(CASE WHEN first_rank = 1 THEN score END) AS first_score,
MAX(CASE WHEN last_rank = 1 THEN score END) AS latest_score
FROM ranked
GROUP BY student_id, subject
HAVING
MAX(CASE WHEN first_rank = 1 THEN score END) <
MAX(CASE WHEN last_rank = 1 THEN score END)
AND MAX(exam_count) >= 2
ORDER BY student_id ASC, subject ASC;
