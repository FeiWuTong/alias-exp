#!/bin/sh
# Usage:
# bash autobuild.sh <id>

# - <id>: node's index


if [ $# -lt 1 ]; then
	echo "Usage: bash init.sh <id>"
	exit 1
fi
id=`printf "%02d" $1`
datadir=data/$id

# set password and create account, save its address
addr=$(./geth --datadir $datadir --password <(echo -n '123') account new 2>/dev/null | grep address | sed -n 's/0x//p' | grep -o '\w\{40\}')
# allocate token for [address] and make a unlock boot_geth_script
sed -i "s/{\"\w\{40\}\"/{\"$addr\"/" genesis.json
