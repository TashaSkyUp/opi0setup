#!/bin/bash

opiFile="/boot/bin/orangepizero.bin"
opiTestFile="/boot/bin/orangepizerotest.bin"
opiTmpFile="./temp.fex"
opiScriptBinFile="/boot/script.bin"

function updateTmpFile {
	echo "$1"
	exit 0
	line=$(cat $opiTmpFile | grep "cooler0 = ........" -o)
	echo $line
	last=$(echo $line | cut -d'"' -f 2)
	echo "($last)"
	sed -i "s/$last/$2/g" $opiTmpFile
}
echo "show dialog"
whiptail --title "orangepizero.bin" --msgbox "save and exit"  10 25
echo "bin->fex"

case $1 in
"--revert")
echo  "revert"
;;
"")
echo "no params"
;;
*)
	echo "default"
	updateTmpFile

;;
esac
exit 0

if [ -z "$*" ]
	then #no arguments passed
	opiUseFile=$opiTestFile
	else

	opiUseFile=opi
fi

exit 0

if [ -e $opiTestFile ]
then 
echo "exists"
bin2fex $opiTestFile $opiTmpFile
else
echo "new run"
bin2fex $opiFile $opiTmpFile
fi


echo "nano"
nano $opiTempFile
echo "fex->bin"
fex2bin $opiTmpFile $opiTestFile 
rm $opiTmpFile
ln -sf $opiTestFile $opiScriptBinFile

function updateMinMaxFile{
echo "ENABLE=true
MIN_SPEED=$1
MAX_SPEED=$2
GOVERNOR=performance" > /etc/default/cpufrequtils
}
