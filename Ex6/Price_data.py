#!/usr/bin/env python3

import re
import random 
import time
from scapy.all import *

src_ip= "192.168.10.1"
dst_ip= "192.168.10.2"
ip_layer = IP()
ip_layer.src =src_ip
ip_layer.dst = dst_ip


class price_data(Packet):
	name = "price_data"
	fields_desc = [ IntField("price",0),   #define to price header
                        IntField("time", 0),
                        IntField("signal", 0),]

eth_pkt =Ether(dst='e4:5f:01:84:8c:86', type=0x1234)
i=0
for i in range(0,10):
	packet = eth_pkt/ip_layer/price_data(price=random.randrange(0,100),time=i)
	i+=1
	print(packet.summary)
	#sendp(packet,iface="eth0")
	time.sleep(1)


