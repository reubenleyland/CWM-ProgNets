/* -*- P4_16 -*- */
#include <core.p4>
#include <v1model.p4>



/*************************************************************************
*********************** H E A D E R S  ***********************************
*************************************************************************/

typedef bit<9>  egressSpec_t;
typedef bit<48> macAddr_t;
register<bit<32>>(10) price_data_array

counter index {
	type : packets;
	size : 32;
}

header ethernet_t {
    macAddr_t dstAddr;
    macAddr_t srcAddr;
    bit<16>   etherType;
}
const bit<16> price_data_ETYPE = 0x1234;

header price_data_t{
	bit<32> price;
	bit<32> time;
	bit<32> signal;

}

struct metadata {
    /* empty */
}

struct headers {
    ethernet_t   ethernet;
    price_data_t     price_data;
    
    
}

/*************************************************************************
*********************** P A R S E R  ***********************************
*************************************************************************/

parser MyParser(packet_in packet,
                out headers hdr,
                inout metadata meta,
                inout standard_metadata_t standard_metadata) {
    state start {
        packet.extract(hdr.ethernet);
        transition select(hdr.ethernet.etherType) {
            price_data_ETYPE : parse_price_data;
            default      : accept;
        }
    }


    state parse_price_data {
        packet.extract(hdr.price_data);
        transition accept;
    }
}
/*************************************************************************
************   C H E C K S U M    V E R I F I C A T I O N   *************
*************************************************************************/

control MyVerifyChecksum(inout headers hdr, inout metadata meta) {
    apply {  }
}


/*************************************************************************
**************  I N G R E S S   P R O C E S S I N G   *******************
*************************************************************************/

control MyIngress(inout headers hdr,
                  inout metadata meta,
                  inout standard_metadata_t standard_metadata) {

action send_back() {
       macAddr_t tmp_mac;
       tmp_mac = hdr.ethernet.dstAddr;
       hdr.ethernet.dstAddr = hdr.ethernet.srcAddr;
       hdr.ethernet.srcAddr = tmp_mac;
       
      standard_metadata.egress_spec = standard_metadata.ingress_port;
    }

action save_price_data(hdr.price_data.price,index)
	price_data_array.write(index,data)
	
action increment_counter() {
	index.count(1)
}

action buy_signal(){
 	hdr.price_data.signal =  1  
 	}
action sell_signal(){
 	hdr.price_data.signal =  0  
 	} 
action operation_drop() {
        mark_to_drop(standard_metadata);
        }
apply(increment_counter)
apply(save_[price_data_array.write)
	     
apply{
	if(hdr.price_data.price>price_data_array[index-1]){
	sell_signal()
	send_back()
	}
	if(hdr.rpice_data.price<price_daya_array[index-1]){
	buy_signal
	send_back()
	else{
	operation_drop()
	
	
	
 
 
  
/*************************************************************************
****************  E G R E S S   P R O C E S S I N G   *******************
*************************************************************************/

control MyEgress(inout headers hdr,
                 inout metadata meta,
                 inout standard_metadata_t standard_metadata) {
    apply { }
}

/*************************************************************************
*************   C H E C K S U M    C O M P U T A T I O N   **************
*************************************************************************/

control MyEgress(inout headers hdr,
                 inout metadata meta,
                 inout standard_metadata_t standard_metadata) {
    apply { }
}

/*************************************************************************
***********************  D E P A R S E R  *******************************
*************************************************************************/

control MyDeparser(packet_out packet, in headers hdr) {
    apply {
        packet.emit(hdr.ethernet);
        packet.emit(hdr.price_data);
    }
}

/*************************************************************************
***********************  S W I T C H  *******************************
*************************************************************************/

V1Switch(
MyParser(),
MyVerifyChecksum(),
MyIngress(),
MyEgress(),
MyComputeChecksum(),
MyDeparser()
) main;
