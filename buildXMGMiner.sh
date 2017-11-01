#!/bin/bash
case $1 in
"--download")
arch="$(uname -m)"

apt-get install automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev make g++ git libgmp-dev -y
git clone https://github.com/novaspirit/wolf-m7m-cpuminer
;;
"--build")
cd wolf-m7m-cpuminer 
./autogen.sh
./configure
make -j4

case $arch in
"x86_64")
echo "verified $arch"
cd ..
rm ./wolf$arch -R -f
cp ./wolf-m7m-cpuminer ./wolf$arch -R
rm ./wolf-m7m-cpuminer -R -f
;;
"armv7l")
echo "verified $arch"
;;
esac
esac
