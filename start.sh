#!/bin/bash
a="$(lscpu | grep "x86_64")"
b="$(lscpu | grep "armv7l")"
if [ ${#a} -eq 0 ]
then
else
c="x86_64"
fi
if [ ${#b} -eq 0 ]
then
else
c="armv7l"
fi
case "$c" in
"x86_64")
echo "64"
;;
"armv7l")
echo "arm"
;;
*)
echo "nada"
;;
esac
exit 0
a=$(service rpimonitor status)
a=$(echo "$a" | grep "not-found" -o)
echo "-$a-"
#exit 0

if [ ${#a} -eq 0 ]
then
echo "is already installed"

cd wolf-arm
./start.sh
armbianmonitor -m

else
armbianmonitor -r
echo "not yet installed - will install"
cd wolf-arm
./start.sh
armbianmonitor -m

fi

