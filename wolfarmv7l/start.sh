#!/bin/bash
ip="$(ip addr show | grep "192.168.1.7." -o)"
echo "test $ip"
machine="$(echo $ip| cut -d'7' -f 2)"
echo "test $machine"

./minerd -S -a m7mhash -o stratum+tcp://mining.m-hash.com:3334 -u TashaSkyUp.opi0$machine -p !Biago123 -B
