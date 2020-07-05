#!/usr/bin/bash


#eth0  nat 模式
# 192.168.115.2


function set_master_eth0()
{

maceth=$(cat /sys/class/net/eth0/address)

cat > /etc/sysconfig/network-scripts/ifcfg-eth0 << EOF
HWADDR=${maceth}
TYPE="Ethernet"
BOOTPROTO="dhcp"
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
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="eth0"
DEVICE="eth0"
ONBOOT="yes"
EOF
}

function set_master_eth1()
{
#获取eth3接口的mac地址(hostnoly mode)
#没网关地址
maceth=$(cat /sys/class/net/eth1/address)

cat > /etc/sysconfig/network-scripts/ifcfg-eth1 << EOF
HWADDR=${maceth}
TYPE="Ethernet"
BOOTPROTO="dhcp"
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
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="eth1"
DEVICE="eth1"
ONBOOT="yes"
EOF
}


#设置master eth2网口的地址(host only)
function set_master_eth2()
{
master_node_name=$(/usr/bin/bash readini.sh cluster_variables.ini default master)
NAMEHOST=$master_node_name
host_ip=$(/usr/bin/bash readini.sh cluster_variables.ini default ip_master)
CUR_PATH=$PWD

#获取eth2接口的mac地址(hostnoly mode)
#没网关地址
maceth2=$(cat /sys/class/net/eth2/address)

#主节点为eth2接口
cat > /etc/sysconfig/network-scripts/ifcfg-eth2 << EOF
HWADDR=${maceth2}
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
IPADDR=${host_ip}
NETMASK=255.255.255.0
DNS1=192.168.142.1
EOF
}

#设置  master eth3网口的地址(host only)
function set_master_eth3()
{
#获取eth3接口的mac地址(hostnoly mode)
#没网关地址
maceth3=$(cat /sys/class/net/eth3/address)

cat > /etc/sysconfig/network-scripts/ifcfg-eth3 << EOF
HWADDR=${maceth3}
TYPE="Ethernet"
BOOTPROTO="dhcp"
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
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="eth3"
DEVICE="eth3"
ONBOOT="yes"
EOF
}


if [ ! -f "/etc/sysconfig/network-scripts/ifcfg-eth0" ];then
   set_master_eth0()
fi

if [ ! -f "/etc/sysconfig/network-scripts/ifcfg-eth1" ];then
   set_master_eth1()
fi

if [ ! -f "/etc/sysconfig/network-scripts/ifcfg-eth2" ];then
   set_master_eth2()
fi

if [ ! -f "/etc/sysconfig/network-scripts/ifcfg-eth3" ];then
   set_master_eth3()
fi