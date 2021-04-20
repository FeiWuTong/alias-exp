#!/bin/sh
# Usage:
# bash node.sh <kind> <id> [<boot>]


if [ $# -lt 2 ]; then
	echo "Usage: bash node.sh <kind> <id> [<boot>]"
	exit 1
fi

# basic information
kind=$1
shift
id=`printf "%02d" $1`
shift
datadir=data/$id
httpprefix=85
portprefix=303
# your lan
net=10.10.9.0/24
legal=("nat" "miner" "full")

if [[ "${legal[@]}" =~ "$kind" ]]; then
	# init with genesis.json
	./geth --datadir $datadir init genesis.json 2>/dev/null
	# make startup script
	if [ "$1" ]; then
		bash make.sh $id $httpprefix$id $portprefix$id $net $(cat $1)
	else
		bash make.sh $id $httpprefix$id $portprefix$id $net
	fi
	if [ $kind == "nat" ]; then
		bash specialrun.sh $kind $id $(cat extip)
		# output this node's enr
		# or use eth=`sed -e 's/\(.*\) 2>>.*/\1/' $id.sh`
		eth=`grep -oP '.*(?= 2>>.*)' $id.sh`
		cmd="$eth js <(echo 'console.log(admin.nodeInfo.enr);')"
		bash -c "$cmd" 2>/dev/null >enr
	elif [ $kind == "miner" ]; then
		# create a coinbase address
		./geth --datadir $datadir --password <(echo -n '123') account new >/dev/null 2>&1
	fi
else
	echo "<kind> must in [${legal[@]}]"
fi

