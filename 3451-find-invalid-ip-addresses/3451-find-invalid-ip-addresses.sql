WITH parts AS (
    SELECT
        l.ip,
        regexp_split_to_table(l.ip, '\.') AS part,
        COUNT(*) OVER (PARTITION BY l.ip) AS octet_count
    FROM logs l
),
invalid_ip AS (
    SELECT ip
    FROM parts
    GROUP BY ip, octet_count
    HAVING
        octet_count <> 4
        OR MAX(
            CASE 
                WHEN part ~ '^[0-9]+$' AND CAST(part AS INT) > 255 THEN 1 ELSE 0 END
        ) = 1
        OR MAX(
            CASE 
                WHEN part ~ '^[0-9]+$' AND LENGTH(part) > 1 AND LEFT(part,1) = '0'
                THEN 1 ELSE 0 END
        ) = 1
)
SELECT ip, COUNT(*) AS invalid_count
FROM logs
WHERE ip IN (SELECT ip FROM invalid_ip)
GROUP BY ip
ORDER BY invalid_count DESC, ip DESC;

