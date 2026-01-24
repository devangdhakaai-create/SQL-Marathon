WITH trial AS (
    SELECT
        user_id,
        AVG(activity_duration)::numeric(10,2) AS trial_avg_duration
    FROM UserActivity
    WHERE activity_type = 'free_trial'
    GROUP BY user_id
),
paid AS (
    SELECT
        user_id,
        AVG(activity_duration)::numeric(10,2) AS paid_avg_duration
    FROM UserActivity
    WHERE activity_type = 'paid'
    GROUP BY user_id
),
converted AS (
    SELECT DISTINCT user_id
    FROM UserActivity
    WHERE activity_type = 'free_trial'
    INTERSECT
    SELECT DISTINCT user_id
    FROM UserActivity
    WHERE activity_type = 'paid'
)

SELECT
    c.user_id,
    t.trial_avg_duration,
    p.paid_avg_duration
FROM converted c
LEFT JOIN trial t USING (user_id)
LEFT JOIN paid  p USING (user_id)
ORDER BY c.user_id;
