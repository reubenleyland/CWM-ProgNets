#!/usr/bin/env python3

import re
import random 
from scapy.all import *

class price_data(Packet):
	name = "price_data"
	fields_desc = [ IntField("price",0),   #define to price header
                        IntField("time", 0),
                        IntField("signal", 0),]

eth_pkt =Ether(dst='00:04:00:00:00:00', type=0x1234)
i=0
for i in range(0,10):
	packet = eth_pkt/price_data(price=random.randrange(0,100),time=i)
	i+=1
	print(packet.summary)
	

