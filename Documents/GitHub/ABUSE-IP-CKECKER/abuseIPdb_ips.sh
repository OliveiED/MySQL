#!/bin/bash

 for counter in $(seq 1 254)
 do
abuseipdb -C 189.124.15."$counter" -v -1 10 > /root/rede_189.124.15.x
 done
