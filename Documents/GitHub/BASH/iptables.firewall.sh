#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

#### OS ENDEREÇOS IP/MASK FORAM ALTERADOS PARA PRESERVA SUA ORIGEM ###
modprobe ip_tables
#modprobe ip_conntrack
modprobe iptable_filter
modprobe iptable_nat
modprobe ipt_LOG
modprobe ipt_limit
modprobe ipt_state
modprobe ipt_owner
modprobe ipt_REJECT
modprobe ipt_MASQUERADE
modprobe ip_conntrack_ftp
modprobe ip_nat_ftp
#modprobe nf_conntrack_pptp
modprobe nf_nat_pptp
#modprobe ip_gre
#modprobe nf_conntrack_proto_gre
#modprobe nf_nat_proto_gre


#IFWAN="eth1"
IFLAN="eth0"
IPWAN="$(ifconfig eth0|grep "inet end"|gawk -F: '{ print $2}' |gawk '{ print $1}                                                                                                                                                             ')"
IPT="/sbin/iptables"
INTERNET13="10.10.10.0/24"
INTERNET14="10.10.9.0/24"
INTERNET15="10.10.8.0/24"
FREEWAY177="10.10.8.0/22"
FREEWAY179="10.10.0.0/24"
FREEWAY192="192.168.0.0/16"
FREEWAY172="172.16.0.0/12"
MSLINK="172.16.0.0/20"
GERENCIA="172.16.16.0/24"
PPPOE="100.64.0.0/10"

/bin/echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6

# Apagando todas regras
$IPT -F
#$IPT -t nat -F
$IPT -X
#$IPT -t nat -F
#$IPT -t mangle -F
#$IPT -t nat -X
#$IPT -t mangle -X

# Politica Padrao

$IPT -P INPUT DROP
$IPT -P OUTPUT ACCEPT
#$IPT -P FORWARD ACCEPT
$IPT -P FORWARD DROP



{
/bin/echo "nameserver 8.8.8.8" #> /etc/resolv.conf
/bin/echo "nameserver 8.8.4.4" #> /etc/resolv.conf
/bin/echo "nameserver 1.1.1.1" #> /etc/resolv.conf
#/bin/echo "nameserver 1.1.1.1" #>> /etc/resolv.conf

} > /etc/resolv.conf


# Regras de INPUT

# Conexoes estabelecidas
$IPT -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT


$IPT -A INPUT -p icmp -j ACCEPT
$IPT -A INPUT -i lo -j ACCEPT

#### GERENCIA
$IPT -A INPUT -s 127.0.0.1 -j ACCEPT
$IPT -A INPUT -s x.x.x.x -j ACCEPT
$IPT -A INPUT -s $GERENCIA -j ACCEPT
# Regras TCP (Portas 10051 e 22)
#$IPT -A INPUT -s 10.10.10.0/24 -p tcp --dport 10051 -j ACCEPT
#$IPT -A INPUT -s 10.10.9.0/24 -p tcp --dport 10051 -j ACCEPT
#$IPT -A INPUT -s 10.10.8.1 -p tcp --dport 22 -j ACCEPT
#$IPT -A INPUT -s $INTERNET13 -p udp --dport 53 -j ACCEPT
#$IPT -A INPUT -s $INTERNET14 -p udp --dport 53 -j ACCEPT
#$IPT -A INPUT -s $INTERNET15 -p udp --dport 53 -j ACCEPT
#$IPT -A INPUT -s $FREEWAY177 -p udp --dport 53 -j ACCEPT
#$IPT -A INPUT -s $FREEWAY192 -p udp --dport 53 -j ACCEPT
#$IPT -A INPUT -s $FREEWAY172 -p udp --dport 53 -j ACCEPT
#$IPT -A INPUT -s $FREEWAY179 -p udp --dport 53 -j ACCEPT
#$IPT -A INPUT -s $MSLINK -p udp --dport 53 -j ACCEPT
#$IPT -A INPUT -s $PPPOE -p udp --dport 53 -j ACCEPT