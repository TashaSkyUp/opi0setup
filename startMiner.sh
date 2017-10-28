#!/bin/bash
arch="$(uname -m)"
minerDir="wolf$arch"
cd $minerDir
ip="$(hostname -I)"
echo "using IP $ip"
machine="$arch$(echo $ip| cut -d'.' -f 4)"
echo "test $machine"

./minerd -S -a m7mhash -o stratum+tcp://mining.m-hash.com:3334 -u TashaSkyUp.$machine -p !Biago123 -B
