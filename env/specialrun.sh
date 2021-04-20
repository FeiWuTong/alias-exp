#!/bin/sh
# Usage:
# bash specialrun.sh <type> <id> [<nat>]

# - <type>: [tx|nat], tx will add unlock option, nat will add nat option 
# - <id>: mark node id

if [ $# -lt 2 ]; then
	echo "Usage: bash specialrun.sh <type> <id>"
	exit 1
fi

nodetype=$1
shift
id=$1
shift

if [ $nodetype == "tx" ]; then
	if [ -d data/$id/keystore ]; then
		addr=$(ls data/$id/keystore | head -1 | sed -e 's/.*--\(\w*\)/\1/')
		para=$(cat $id.sh | cut -d ' ' -f2-)
		new="./geth --allow-insecure-unlock --unlock $addr --password <(echo -n '123') $para"
		echo $new >$id.sh
	else
		exit 1
	fi
elif [ $nodetype == "nat" ]; then
	para=$(cat $id.sh | cut -d ' ' -f2-)
	new="./geth --nat extip:$1 $para"
	echo $new >$id.sh
fi

