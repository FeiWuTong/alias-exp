#!/bin/sh
# Usage:
# bash make.sh <dir> <httpport> <port> [<net> <boot>]
if [ $# -lt 3 ]; then
	echo "Usage: bash make.sh <dir> <httpport> <port> [<net> <boot>]"
	exit 1
else
	prefix="./geth --datadir data/$1 --identity $1 --networkid 50821 --http --http.api 'eth,net,web3,miner,personal' --http.addr localhost --http.port $2 --port $3 --maxpeers 150"
	suffix="2>>log/$1.log &"
	if [ "$4" ]; then
		out="$prefix --netrestrict $4"
	fi
	if [ "$5" ]; then
		out="$out --bootnodes $5"
	fi
	echo "$out $suffix" > $1.sh
fi
