#!/bin/bash
if [ -z "$*" ]
then
exit 0
fi
opiFile="/boot/bin/orangepizero.bin"
opiTestFile="/boot/bin/orangepizerotest.bin"
echo "show dialog"
whiptail --title "orangepizero.bin" --msgbox "save and exit"  10 25
echo "bin->fex"

if [ -e $opiTestFile ]
then 
echo "exists"
bin2fex /boot/bin/orangepizerotest.bin ./temp.fex
else
echo "new run"
bin2fex /boot/bin/orangepizero.bin ./temp.fex
fi

line=$(cat ./temp.fex | grep "cooler0 = ........" -o)
echo $line
last=$(echo $line | cut -d'"' -f 2)
echo "($last)"
sed -i "s/$last/$2/g" ./temp.fex
echo "nano"
nano ./temp.fex
echo "fex->bin"
fex2bin ./temp.fex /boot/bin/orangepizerotest.bin
rm ./temp.fex
#cp -f /boot/bin/orangepizerotest.bin /boot/script.bin
ln -sf /boot/bin/orangepizerotest.bin /boot/script.bin

echo "ENABLE=true
MIN_SPEED=$1
MAX_SPEED=$2
GOVERNOR=performance" > /etc/default/cpufrequtils
