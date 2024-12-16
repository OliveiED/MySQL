-- ULTIMO VALOR DO ICMP PING E SITE COUNTRY + LONG AND LAT
-- Consulta serve para estrutura do Banco de Dados MySQL - Zabbix Ver 4.5
WITH LatestValues AS (
    SELECT 
        hu.itemid, 
        hu.value, 
        hu.clock,
        ROW_NUMBER() OVER (PARTITION BY hu.itemid ORDER BY hu.clock DESC) AS rn
    FROM zabbix.history_uint hu
    JOIN zabbix.items it ON hu.itemid = it.itemid
    WHERE it.key_ = 'icmpping'
)
SELECT DISTINCT 
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
JOIN LatestValues lv ON it.itemid = lv.itemid AND lv.rn = 1
JOIN hosts_groups hg ON ht.hostid = hg.hostid
JOIN hstgrp g ON hg.groupid = g.groupid
LEFT JOIN host_inventory hi ON ht.hostid = hi.hostid
LIMIT 100;
