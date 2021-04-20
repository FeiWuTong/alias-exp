#!/bin/sh
# Usage:
# bash scp.sh [FILENAME]

scpfile=$1
shift
ipfile="ip.txt"
user=mcloud
aimdir=exp/alias/

cat $ipfile | while read ip; do
    scp $scpfile $user@$ip:/home/$user/$aimdir
done
