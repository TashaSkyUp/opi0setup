#!/bin/bash

opiFile="/boot/bin/orangepizero.bin"
opiTestFile="/boot/bin/orangepizerotest.bin"
opiTmpFile="./temp.fex"
opiScriptBinFile="/boot/script.bin"
opiUseFile=$opiTestFile

if [ $(bin2fex -h) -ge 0 ];
then 
	echo "error"
else 
	echo "done"
fi
exit 0
function updateTmpFile {
	line=$(cat $opiTmpFile | grep "cooler0 = ........" -o)
	echo $line
	last=$(echo $line | cut -d'"' -f 2)
	echo "($last)"
	sed -i "s/$last/$1/g" $opiTmpFile
}
function fexToBin {
	echo "$globalfex->bin"
	exit 0
	fex2bin $opiTmpFile $opiTestFile 
	rm $opiTmpFile
	ln -sf $opiTestFile $opiScriptBinFile
}

function updateMinMaxFile {
echo "ENABLE=true
MIN_SPEED=$1
MAX_SPEED=$2
GOVERNOR=performance" > /etc/default/cpufrequtils
}

echo "show dialog"
whiptail --title "orangepizero.bin" --msgbox "save and exit"  10 25

echo "bin->fex"
if [ -e $opiTestFile ]
then 
echo "exists"
bin2fex $opiTestFile $opiTmpFile
else
echo "new run"
bin2fex $opiFile $opiTmpFile
fi

case $1 in
"--revert")
	echo  "revert to base config"
;;
"")
	echo "no params - please edit"
	echo "nano"
	nano $opiTempFile
	nano /etc/default/cpufrequtils
	fexToBin
;;
*)
	echo "auto updating "
	$global="testG"
	fexToBin $global
	updateMinMaxFile $1 $2
	updateTmpFile $2

;;
esac
exit 0

