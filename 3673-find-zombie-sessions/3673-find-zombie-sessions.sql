WITH s AS (
  SELECT
    session_id,
    MIN(event_timestamp) AS start_ts,
    MAX(event_timestamp) AS end_ts,
    COUNT(*) FILTER (WHERE event_type = 'scroll') AS scroll_count,
    COUNT(*) FILTER (WHERE event_type = 'click')  AS click_count,
    COUNT(*) FILTER (WHERE event_type = 'purchase') AS purchase_count,
    MIN(user_id) AS user_id
  FROM app_events
  GROUP BY session_id
),
z AS (
  SELECT
    session_id,
    user_id,
    EXTRACT(EPOCH FROM (end_ts - start_ts)) / 60 AS session_duration_minutes,
    scroll_count,
    click_count,
    purchase_count
  FROM s
)
SELECT
  session_id,
  user_id,
  FLOOR(session_duration_minutes) AS session_duration_minutes,
  scroll_count
FROM z
WHERE session_duration_minutes > 30
  AND scroll_count >= 5
  AND (click_count::float / NULLIF(scroll_count,0)) < 0.20
  AND purchase_count = 0
ORDER BY scroll_count DESC, session_id ASC;
