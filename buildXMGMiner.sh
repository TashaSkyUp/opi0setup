#!/bin/bash
apt-get install automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev make g++ git libgmp-dev -y
git clone https://github.com/novaspirit/wolf-m7m-cpuminer
cd wolf-m7m-cpuminer 
$ ./autogen.sh
./configure
make -j4
