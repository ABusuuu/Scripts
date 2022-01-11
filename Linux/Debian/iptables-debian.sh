#!/bin/bash

#apt-get install iptables iptables-persistent

#### FLUSH ####

iptables -F

#### SSH ####

iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

#### LO ####

iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT


#iptables -A INPUT -p tcp -m multiport --dport 80,443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
#iptables -A OUTPUT -p tcp -m multiport --sport 80,443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
#iptables -A INPUT -p udp -m udp --dport 53 -j ACCEPT
#iptables -A OUTPUT -p udp -m udp --sport 53 -j ACCEPT
#iptables -A INPUT -p tcp -m tcp --dport 53 -j ACCEPT
#iptables -A OUTPUT -p tcp -m tcp --sport 53 -j ACCEPT

#### BLOCK ALL #####

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

##### IPv6 ACCEPT #####

ip6tables -P INPUT ACCEPT
ip6tables -P OUTPUT ACCEPT
ip6tables -P FORWARD ACCEPT

##### SAVE #####

netfilter-persistent save
