#!/bin/bash

while IFS= read -r ip; do
    echo "Verificando IP: $ip"
    abuseipdb -C "$ip" -v -1 10 >> relatorio.txt
done < lista_ips.txt

