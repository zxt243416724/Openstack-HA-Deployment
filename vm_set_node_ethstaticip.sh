#!/usr/bin/bash

master_node_name=$(/usr/bin/bash readini.sh cluster_variables.ini default master)
NAMEHOST=$master_node_name
host_ip=$(/usr/bin/bash readini.sh cluster_variables.ini default ip_master)
CUR_PATH=$PWD

#eth0  nat 模式
# 192.168.115.2

#获取eth2接口的mac地址(hostnoly mode)
#没网关地址
maceth2=$(cat /sys/class/net/eth2/address)


#主节点为eth2接口
cat > /etc/sysconfig/network-scripts/ifcfg-eth2 << EOF
HWADDR=$(maceth2)  
TYPE="Ethernet"  
BOOTPROTO="static"  
DEFROUTE="yes"  
PEERDNS="yes"  
PEERROUTES="yes"  
IPV4_FAILURE_FATAL="no"  
IPV6INIT="yes"  
IPV6_AUTOCONF="yes"  
IPV6_DEFROUTE="yes"  
IPV6_PEERDNS="yes"  
IPV6_PEERROUTES="yes"  
IPV6_FAILURE_FATAL="no"  
NAME="eth2"
DEVICE="eth2"  
ONBOOT="yes"
IPADDR=$(host_ip)
NETMASK=255.255.255.0
DNS1=192.168.142.1
EOF

