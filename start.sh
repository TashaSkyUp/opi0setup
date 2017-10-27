#!/bin/bash
a="$(lscpu | grep "x86_64")"
b="$(lscpu | grep "armv7l")"
if [ ${#a} -eq 0 ]
then
echo "not x86_64"
else
c="x86_64"
fi
if [ ${#b} -eq 0 ]
then
echo "not armv7l"
else
c="armv7l"
fi

case "$c" in
"x86_64")
echo "64"
d="wolf-amd64"
;;
"armv7l")
echo "arm"
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
armbianmonitor -r
echo "not yet installed - will install"
cd $d
./start.sh
armbianmonitor -m

fi

