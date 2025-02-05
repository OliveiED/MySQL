-- Consulta serve para estrutura do Banco de Dados MySQL - Zabbix Ver 4.5
WITH LatestValues AS (
    SELECT 
        hu.itemid, 
        hu.value, 
        hu.clock
    FROM zabbix.history_uint hu
    JOIN (
        SELECT itemid, MAX(clock) AS max_clock
        FROM zabbix.history_uint
        GROUP BY itemid
    ) max_hu ON hu.itemid = max_hu.itemid AND hu.clock = max_hu.max_clock
    JOIN zabbix.items it ON hu.itemid = it.itemid
    WHERE it.key_ = 'icmpping'
)
SELECT 
    ht.name AS HOST,
    hi.location_lat AS LATITUDE,
    hi.location_lon AS LONGITUDE,
    hi.site_country AS SITE_COUNTRY,
    it.itemid AS ITEMID,
    it.name AS ITEM, 
    lv.value AS "ULT.VALOR",
    CONVERT_TZ(from_unixtime(lv.clock), '+00:00', '+04:00') AS "ULT.VERIFICACAO"
FROM zabbix.items it
JOIN zabbix.hosts ht ON it.hostid = ht.hostid
JOIN LatestValues lv ON it.itemid = lv.itemid
JOIN hosts_groups hg ON ht.hostid = hg.hostid
JOIN hstgrp g ON hg.groupid = g.groupid
LEFT JOIN host_inventory hi ON ht.hostid = hi.hostid
WHERE g.name = 'Aqui nome do Grupo de Host do Zabbix' -- Filtrar por nome do grupo
LIMIT 60;