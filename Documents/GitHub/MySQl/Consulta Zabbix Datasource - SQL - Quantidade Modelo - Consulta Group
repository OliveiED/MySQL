--Quantidade de Modelo equipamentos, consultando por grupo
--Essa Consulta serve para banco de dados Mysql estrutura tabela Zabbix V 4.5

SELECT COUNT(*) AS QUANTIDADE
FROM host_inventory hi
JOIN hosts h ON hi.hostid = h.hostid
JOIN hosts_groups hg ON h.hostid = hg.hostid
JOIN hstgrp g ON hg.groupid = g.groupid
WHERE hi.model = 'DM4360'
AND g.name = 'INTERIOR';
