#!/usr/bin/env python3

import re
import random 
import time
from scapy.all import *

#src_ip= "192.168.10.1"
#dst_ip= "192.168.10.2"
src_MAC="0c:37:96:5f:89:d4"
dst_MAC= "e4:5f:01:84:8c:86"
#ip_layer = IP()
#ip_layer.src =src_ip
#ip_layer.dst = dst_ip


class price_data(Packet):
	name = "price_data"
	fields_desc = [ IntField("price",0),   #define to price header
                        IntField("time", 0),
                        IntField("signal", 0),]

eth_layer =Ether()
eth_layer.src = src_MAC
eth_layer.dst = dst_MAC
eth_layer.type= 0x1234
i=0
for i in range(0,10):
	packet = eth_layer/price_data(price=random.randrange(0,100),time=i)
	i+=1
	print(packet.summary)
	sendp(packet,iface="enx0c37965f89d4")
	time.sleep(1)


