#!/bin/bash

echo "$(uname -m)"

d="wolf$(uname -m)"

a="$(service rpimonitor status)"
if [ ${#a} -eq 0 ]
then
a="not-found"
fi

function startMiner {
echo "using directory $d"
cd $d
./start.sh
armbianmonitor -m
}

a="$(echo "$a" | grep "not-found" -o)"
echo "-$a-"

if [ ${#a} -eq 0 ]
then
echo "is already installed"

else
echo "not yet installed - will install"

case "$(uname -m)" in
"x86_64")
wget http://goo.gl/vewCLL -O /etc/apt/sources.list.d/rpimonitor.list
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 2C0D3C0F
apt-get update
apt-get install rpimonitor -y --allow-unauthenticated
;;
"armv7l")
armbianmonitor -r
;;
esac
fi

startMiner
