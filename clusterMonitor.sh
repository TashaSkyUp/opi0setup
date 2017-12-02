#!/bin/bash
function getinfo () {
  hostname="$(hostname)"
  mac="$(ifconfig |grep "wlan0" | grep "..:..:..:..:..:.." -o)"
  echo "$mac" > /ramdrv/mac
  clusterNumber="$(curl 172.24.1.1:1880/opi0cluster?register="$mac"'&'khash="$khash" | cut -d',' -f 4| cut -d':' -f2 | grep -o "[0-9]*")" 
  echo "$clusterNumber" > /ramdrv/clusterNumber 
}
  mount -t ramfs -o size=256m ext4 $TARGETDIR/ramdisk
  getinfo  
  sleep 10
  cd /root/opi0setup/
  # would be nice to have auto service updating here
  
  #./start.sh --workername $clusterNumber > /mining.log &
  #preserve old log.
  cp /mining.log /mining.lastboot.log

case $hostname in
  "cl-controller")
    echo "-= Cluster Controller =-"
    clusterNumber="0"
    ./node-red.sh
  ;;
  *)
    echo "cluster node"
  ;;
esac

while [ . ]; do

  for ((i=1;i<=50;i++)); 
  do
    getinfo 

    result="$(ps all | grep "..:[0-9][0-9] ./minerd" -o)"
    case "$result" in

      #is not running
      "")
        echo 0 >/sys/class/leds/red_led/brightness
        #echo "zero length"
        ./start.sh --workername $clusterNumber > /mining.log &
        sleep 30
        ;;

      #is running
      *)
        #echo "non zero len"
        echo 255 >/sys/class/leds/red_led/brightness
        khash="$(tail -c256 /mining.log | grep "acc" | tail -n 1 | grep "), [0-9]*\.[0-9]*" -o | cut -d' ' -f 2)"
        ;;

    esac
    sleep 12
  done
  
  case $hostname in
  "cl-controller")
    echo 0 >/sys/class/leds/red_led/brightness
    clusterNumber="0"
    #reboot
  ;;
  esac
  
done
