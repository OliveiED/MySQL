-- Ajuste o item key para corresponder ao zabbix
-- Ajuste o código abaixo para corresponder a estrutura da tabela zabbix a ser consultada.

select count(DISTINCT ht.hostid) from items it
inner join hosts ht on it.hostid = ht.hostid
inner join hosts_groups hg on (hg.hostid = ht.hostid)
inner join hstgrp g on (g.groupid = hg.groupid)
where it.key_ = 'icmpping' AND g.name in ($grupos);