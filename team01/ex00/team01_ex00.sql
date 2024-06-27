SELECT 
    coalesce(u.name,'not defined') AS name,
    coalesce(u.lastname,'not defined') AS lastname,
    temp.type,
    temp.volume,
    coalesce(c.name,'not defined') AS currency_name,
    coalesce((SELECT rate_to_usd 
                FROM currency c1 
                WHERE c1.id = c.id 
                    AND c1.updated = c.last_updated), 1) AS last_rate_to_usd,
                temp.volume::NUMERIC * coalesce((SELECT rate_to_usd 
                                                    FROM currency c1 
                                                    WHERE c1.id = c.id 
                                                        AND c1.updated = c.last_updated), 1) AS total_volume_in_usd
FROM (
    SELECT 
        user_id, 
        type, 
        currency_id, 
        sum(money) AS volume
    FROM  balance b
    GROUP BY user_id, type, currency_id) AS temp
FULL JOIN "user" u 
    ON u.id = temp.user_id
FULL JOIN ( SELECT 
                id, 
                name,
                max(updated) AS last_updated 
            FROM currency c 
            GROUP BY id, name) AS c 
        ON c.id = temp.currency_id
ORDER BY 1 DESC, 2, 3;