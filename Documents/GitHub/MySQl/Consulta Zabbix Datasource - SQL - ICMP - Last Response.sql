-- Consulta serve para estrutura do Banco de Dados MySQL - Zabbix Ver 4.5
-- Consulta último valor de resposta ICMP Ping - Formatando data e hora
SELECT DISTINCT 
    ht.hostid AS 'HOSTID',
    ht.name AS 'HOST',
    CASE 
        WHEN i.ip <> '' THEN i.ip 
        ELSE i.dns 
    END AS 'IP/DNS',
    CONCAT(ROUND(hu.value * 1000, 2), ' ms') AS "ULT.VALOR", 
    CONVERT_TZ(FROM_UNIXTIME(hu.clock), '+00:00', '+03:00') AS "ULT.VERIFICACAO" 
FROM items it
INNER JOIN hosts ht ON it.hostid = ht.hostid
INNER JOIN hosts_groups hg ON hg.hostid = ht.hostid
INNER JOIN hstgrp g ON g.groupid = hg.groupid
INNER JOIN interface i ON i.hostid = it.hostid
LEFT JOIN (
    SELECT h1.itemid, h1.value, h1.clock 
    FROM history h1
    JOIN (
        SELECT itemid, MAX(clock) AS max_clock 
        FROM history 
        WHERE clock BETWEEN ${__from:date:seconds} AND ${__to:date:seconds} 
        GROUP BY itemid
    ) h2 ON h1.itemid = h2.itemid AND h1.clock = h2.max_clock
) hu ON hu.itemid = it.itemid
WHERE 
    it.key_ = 'icmppingsec' 
    AND ht.status = 0 
    AND hu.value IS NOT NULL 
    AND g.name IN ($grupos)
    AND it.name IN ('ICMP tempo de resposta');

