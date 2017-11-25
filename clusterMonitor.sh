#!/bin/bash

#first find cluster number and start mining
  mac="$(hostname -i| grep "eth0.*%" -o | cut -d' ' -f 2 | cut -d'%' -f 1)"
  clusterNumber="$(curl 172.24.1.1:1880/opi0cluster?register="$mac" | cut -d',' -f 2 | cut -d':' -f2 | grep -o "[0-9]*")" 
  echo "$clusterNumber" > /clusterNumber
  sleep 10
  cd /root/opi0setup/
  start.sh --workername $clusterNumber > /mining.log &

while [ . ]; do
  clusterNumber="$(curl 172.24.1.1:1880/opi0cluster?register="$mac" | cut -d',' -f 2 | cut -d':' -f2 | grep -o "[0-9]*")" 
  echo "$clusterNumber" > /clusterNumber
  sleep 10
done
