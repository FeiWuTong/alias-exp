#!/bin/sh
# Usage: bash cluster.sh <startid> <N> <boot>

if [ $# -lt 3 ]; then
	echo "Usage: bash cluster.sh <startid> <N> <boot>"
	exit 1
fi

startid=$1
shift
N=$1
shift
boot=$1
shift

for ((i=$startid; i<=N; i++)); do
	echo "Generate startup script for fullnode id $i/$N"
	bash node.sh full $i $boot
done

echo "Fullnode generation finshed, from $startid to $N"
