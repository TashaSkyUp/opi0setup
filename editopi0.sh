#!/bin/bash
opiFile="/boot/bin/orangepizero.bin"
opiTestFile="/boot/bin/orangepizerotest.bin"
echo "show dialog"
whiptail --title "orangepizero.bin" --msgbox "save and exit"  10 25
echo "bin->fex"

if [ -e $opiTestFile ]
then 
bin2fex /boot/bin/orangepizerotest.bin ./temp.fex
else
bin2fex /boot/bin/orangepizero.bin ./temp.fex
fi

echo "nano"
nano temp.fex
echo "fex->bin"
fex2bin ./temp.fex /boot/bin/orangepizerotest.bin
rm ./temp.fex

ln -sf /boot/bin/orangepizerotest.bin /boot/script.bin

echo "ENABLE=true
MIN_SPEED=480000
MAX_SPEED=1200000
GOVERNOR=performance" > /etc/default/cpufrequtils
