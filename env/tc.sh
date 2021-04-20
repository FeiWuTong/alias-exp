#!/bin/sh

extdev=enp8s0
bw=10mbit
port=303

# delete exist rules
sudo tc qdisc del dev $extdev root 2>/dev/null
sudo iptables -t mangle -F

# add qdisc, class and filter for each port's traffic control
sudo tc qdisc add dev $extdev root handle 1: htb default 40
sudo tc class add dev $extdev parent 1: classid 1:1 htb rate 500mbit
for ((i=2; i<=40; i++)); do
	sudo tc class add dev $extdev parent 1:1 classid 1:$i htb rate $bw
	id=`printf "%02d" $((i-2))`
	sudo tc filter add dev $extdev protocol ip parent 1:0 prio 1 u32 match ip sport $port$id 0xffff flowid 1:$i
done
#sudo tc class add dev $extdev parent 1:1 classid 1:20 htb rate 10mbit
#sudo tc class add dev $extdev parent 1:1 classid 1:30 htb rate 1mbit
#sudo tc filter add dev $extdev protocol ip parent 1:0 prio 1 u32 match ip dport $port 0xffff flowid 1:30

## Original: use iptables
#sudo tc class add dev $extdev parent 1: classid 1:20 htb rate $bw ceil $bw
#sudo tc qdisc add dev $extdev parent 1:20 handle 20: sfq perturb 10
#sudo tc filter add dev $extdev protocol ip parent 1: prio 1 u32 match ip dport $port 0xffff flowid 1:20
#sudo tc filter add dev $extdev parent 1: protocol ip prio 1 handle 5 fw classid 1:20
#sudo iptables -A INPUT -t mangle -p tcp --dport $port -j MARK --set-mark 5
