-- Ajuste o item key para corresponder ao zabbix
--  Ajuste o código abaixo para corresponder a estrutura da tabela zabbix a ser consultada.

select count(DISTINCT ht.hostid) from items it
inner join hosts ht on it.hostid = ht.hostid
inner join hosts_groups hg on (hg.hostid = ht.hostid)
inner join hstgrp g on (g.groupid = hg.groupid)
left join (select itemid, max(clock) AS max_clock from history_uint WHERE clock BETWEEN ${__from:date:seconds} AND ${__to:date:seconds} group by itemid) max_hu on max_hu.itemid = it.itemid
left join history_uint hu on hu.itemid = max_hu.itemid and hu.clock = max_hu.max_clock
where it.key_ = 'icmpping' and ht.status = 0 and hu.value = 1 AND g.name in ($grupos) AND clock BETWEEN ${__from:date:seconds} AND ${__to:date:seconds};