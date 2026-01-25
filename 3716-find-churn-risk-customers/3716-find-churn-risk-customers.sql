WITH hist AS (
    SELECT
        user_id,
        MIN(event_date) FILTER (WHERE event_type <> 'cancel') AS first_date,
        MAX(event_date) FILTER (WHERE event_type <> 'cancel') AS last_date,
        MAX(monthly_amount) FILTER (WHERE event_type <> 'cancel') AS max_historical_amount,
        BOOL_OR(event_type = 'downgrade') AS has_downgrade
    FROM subscription_events
    GROUP BY user_id
),
latest AS (
    SELECT DISTINCT ON (user_id)
        user_id,
        plan_name AS current_plan,
        monthly_amount AS current_monthly_amount,
        event_type AS last_type,
        event_date AS last_event_date
    FROM subscription_events
    ORDER BY user_id, event_date DESC, event_id DESC
)
SELECT
    l.user_id,
    l.current_plan,
    l.current_monthly_amount,
    h.max_historical_amount,
    (h.last_date - h.first_date) AS days_as_subscriber
FROM latest l
JOIN hist h USING (user_id)
WHERE
    l.last_type <> 'cancel'
    AND h.has_downgrade = TRUE
    AND l.current_monthly_amount < 0.5 * h.max_historical_amount
    AND (h.last_date - h.first_date) >= 60
ORDER BY
    days_as_subscriber DESC,
    user_id ASC;
