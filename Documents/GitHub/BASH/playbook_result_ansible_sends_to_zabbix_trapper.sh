#!/bin/bash

# Caminho para os arquivos de resultados de ping
#set -x
DIRETORIO="/home/admin/my-setup-ansible"



IPS=$(ls -l /home/admin/my-setup-ansible/ping_results/ | awk '{print $9}' | grep -v ^$)

#IPS="189.126.255.201  189.126.255.202  189.126.255.49  189.126.255.91"

for ip in $IPS
do
result_avg_rtt_1=ping_results/$ip/result_avg-rtt_179.124.11.36.txt
result_avg_rtt_2=ping_results/$ip/result_avg-rtt_200.179.93.161.txt
result_packet_loss_1=ping_results/$ip/result_packet-loss_179.124.11.36.txt
result_packet_loss_2=ping_results/$ip/result_packet-loss_200.179.93.161.txt
#done

#set +x
echo
echo
echo


# Extraindo o valor de avg_rtt para 179.124.11.36
#


#
set -x
avg_rtt_1=$(grep -oP '^\["?\K[0-9]+(?=ms)' "$DIRETORIO/$result_avg_rtt_1")
if [[ -z "$avg_rtt_1_$ip" ]]; then
    echo "Erro: Não foi possível extrair avg_rtt de $DIRETORIO/$result_avg_rtt_1"
else
    echo "Valor de avg_rtt (do host $ip para 179.124.11.36 e): $avg_rtt_1"

   if [ $avg_rtt_1 == '']; then
          zabbix_sender -z 172.16.30.113 -s "$ip" -k "avg_rtt_179.124.11.36" -o "10000"
  else
zabbix_sender -z 172.16.30.113 -s "$ip" -k "avg_rtt_179.124.11.36" -o "$avg_rtt_1"
fi
fi


# Extraindo o valor de avg_rtt para 200.179.93.161
avg_rtt_2=$(grep -oP '^\["?\K[0-9]+(?=ms)' "$DIRETORIO/$result_avg_rtt_2")
if [[ -z "$avg_rtt_2_$ip" ]]; then
    echo "Erro: Não foi possível extrair avg_rtt de $DIRETORIO/$result_avg_rtt_2"
else
    echo "Valor de avg_rtt (do host $ip para 200.179.93.161 e): $avg_rtt_2"

   if [ $avg_rtt_2 == '']; then
          zabbix_sender -z 172.16.30.113 -s "$ip" -k "avg_rtt_200.179.93.161" -o "10000"
else
zabbix_sender -z 172.16.30.113 -s "$ip" -k "avg_rtt_200.179.93.161" -o "$avg_rtt_2"
fi
fi

set +x
# Extraindo o valor de packet loss para 179.124.11.36
packet_loss_1=$(grep -oP '[0-9]+(?=%)' "$DIRETORIO/$result_packet_loss_1")
if [[ -z "$packet_loss_1$ip" ]]; then
    echo "Erro: Não foi possível extrair packet_loss de $DIRETORIO/$result_packet_loss_1"
else

    echo "Valor de packet_loss (do host $ip para 179.124.11.36 e): $packet_loss_1"

   if [ $packet_loss_1 == '']; then
          zabbix_sender -z 172.16.30.113 -s "$ip" -k "packet_loss_179.124.11.36" -o "100"
else

zabbix_sender -z 172.16.30.113 -s "$ip" -k "packet_loss_179.124.11.36" -o "$packet_loss_1"
fi
fi

# Extraindo o valor de packet loss para 200.179.93.161
packet_loss_2=$(grep -oP '[0-9]+(?=%)' "$DIRETORIO/$result_packet_loss_2")
if [[ -z "$packet_loss_2$ip" ]]; then
    echo "Erro: Não foi possível extrair packet_loss de $DIRETORIO/$result_packet_loss_2"
else
    echo "Valor de packet_loss (do host $ip para 200.179.93.161 e): $packet_loss_2"

   if [ $packet_loss_2 == '']; then
          zabbix_sender -z 172.16.30.113 -s "$ip" -k "packet_loss_200.179.93.161" -o "100"
else

zabbix_sender -z 172.16.30.113 -s "$ip" -k "packet_loss_200.179.93.161" -o "$packet_loss_2"
fi
fi

done

echo
echo
echo "Fim da segunda etapa" -------------------------------------
echo
echo
echo