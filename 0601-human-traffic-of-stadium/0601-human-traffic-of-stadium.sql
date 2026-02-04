-- SELECT s1.id, s1.visit_date, s1.people
-- FROM Stadium s1
-- JOIN Stadium s2 ON s2.id = s1.id + 1
-- JOIN Stadium s3 ON s3.id = s1.id + 2
-- WHERE s1.people >= 100
--   AND s2.people >= 100
--   AND s3.people >= 100
-- ORDER BY s1.visit_date;

WITH grouped AS (
    SELECT
        id,
        visit_date,
        people,
        id - ROW_NUMBER() OVER (ORDER BY id) AS grp
    FROM Stadium
    WHERE people >= 100
),
valid_groups AS (
    SELECT grp
    FROM grouped
    GROUP BY grp
    HAVING COUNT(*) >= 3
)
SELECT g.id, g.visit_date, g.people
FROM grouped g
JOIN valid_groups v
  ON g.grp = v.grp
ORDER BY g.visit_date;

