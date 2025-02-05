--Formatado para trazer ultimo evento e data junto com lat and long
--Essa consulta via MYSQL consulta estrutura da tabela Zabbix 4.5 - Ultimo Evento ID
SELECT 
    e.eventid AS EVENTID,
    ht.name AS HOST,
    hi.location_lat AS latitude,
    hi.location_lon AS longitude,
    e.name AS ULTIMO_EVENTO,
    DATE_FORMAT(FROM_UNIXTIME(e.clock), '%d/%m/%Y %H:%i:%s') AS txtStartDate
FROM zabbix.events e
JOIN zabbix.functions f ON e.objectid = f.triggerid
JOIN zabbix.items i ON f.itemid = i.itemid
JOIN zabbix.hosts ht ON i.hostid = ht.hostid
LEFT JOIN host_inventory hi ON ht.hostid = hi.hostid
WHERE e.severity IN (3, 4)
ORDER BY e.clock DESC
LIMIT 10;
