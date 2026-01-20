-- f = each player's first login day
-- r = players who also logged in exactly 1 day after
WITH f AS (
    SELECT player_id, MIN(event_date) AS d
    FROM Activity
    GROUP BY player_id
),
r AS (
    SELECT f.player_id
    FROM f
    JOIN Activity a
      ON a.player_id = f.player_id
     AND a.event_date = f.d + INTERVAL '1 day'
)
SELECT ROUND(
    COUNT(*)::numeric / (SELECT COUNT(*) FROM f), 
    2
) AS fraction
FROM r;
