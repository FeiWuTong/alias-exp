#!/bin/sh
# Usage:
# bash run.sh <startid> <endid>

if [ $# -lt 2 ]; then
	echo "Usage: bash run.sh <startid> <endid>"
	exit 1
fi

start=$1
shift
end=$1
shift

for ((i=$start; i<=end; i++)); do
	id=`printf "%02d" $i`
	echo "launching node $i/$end ---> tail -f log/$id.log"
	bash $id.sh
done
