WITH cnt AS (
    SELECT 
        user_id,
        COUNT(*) AS total_reactions
    FROM reactions
    GROUP BY user_id
    HAVING COUNT(*) >= 5
),
agg AS (
    SELECT
        r.user_id,
        r.reaction,
        COUNT(*) AS reaction_count
    FROM reactions r
    INNER JOIN cnt c USING(user_id)
    GROUP BY r.user_id, r.reaction
),
dom AS (
    SELECT
        user_id,
        reaction,
        reaction_count,
        total_reactions,
        reaction_count::decimal / total_reactions AS ratio,
        ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY reaction_count DESC) AS rn
    FROM agg a
    JOIN cnt c USING(user_id)
)
SELECT
    user_id,
    reaction AS dominant_reaction,
    ROUND(ratio, 2) AS reaction_ratio
FROM dom
WHERE rn = 1 AND ratio >= 0.60
ORDER BY reaction_ratio DESC, user_id ASC;
