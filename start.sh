#!/bin/bash
a="$(lscpu | grep "Architecture:")"
case "$a" in
"Architecture:        x86_64")
echo "64"
;;
"Architecture:        armv71")
echo "arm"
;;
*)
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

