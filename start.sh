#!/bin/bash

echo "$(uname -m)"

case "$(uname -m)" in
"x86_64")

d="wolf-amd64"
;;
"armv7l")
echo "armv7l"
d="wolf-arm"
;;
*)
echo "nada"
;;
esac

a="$(service rpimonitor status)"
if [ ${#a} -eq 0 ]
then
a="not-found"
fi
a="$(echo "$a" | grep "not-found" -o)"
echo "-$a-"

if [ ${#a} -eq 0 ]
then
echo "is already installed"

cd $d
./start.sh
armbianmonitor -m

else
echo "not yet installed - will install"

case "$(uname -m)" in
"x86_64")
wget http://goo.gl/vewCLL -O /etc/apt/sources.list.d/rpimonitor.list
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 2C0D3C0F
apt-get update
apt-get install rpimonitor -y
;;
"armv7l")
armbianmonitor -r
;;
esac



cd $d
./start.sh
armbianmonitor -m

fi


