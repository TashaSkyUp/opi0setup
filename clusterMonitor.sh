#!/bin/bash
function getinfo () {
  hostname="$(hostname)"
  mac="$(ifconfig |grep "wlan0" | grep "..:..:..:..:..:.." -o)"
  echo "$mac" > /ramdrv/mac
  
  case $hostname in
    "cl-controller")
      echo 0 >/sys/class/leds/red_led/brightness
      clusterNumber="0"
      mac="Cluster_Controller"
      #reboot
    ;;
  esac
  clusterNumber="$(curl 172.24.1.1:1880/opi0cluster?register="$mac"'&'khash="$khash" | cut -d',' -f 4| cut -d':' -f2 | grep -o "[0-9]*")" 
  echo "$clusterNumber" > /ramdrv/clusterNumber
}

function getjsonresult () {
 #result="$(echo "$1"  | cut -d',' -f $2| cut -d':' -f2 | cut -d'"' -f 2)"  && echo "-= $result =-" && echo "1"
  result="$(echo "$1"  | cut -d',' -f $2| cut -d':' -f2 | cut -d'"' -f 2)"
  echo "$result" 
}

function loggit () {
  #result="$(curl 172.24.1.1:1880/log?mac="$mac"'&'$1="$2" | cut -d',' -f 2| cut -d':' -f2 | cut -d'"' -f 2)"  && echo "-= $result =-" && echo "1"
  result="$(curl 172.24.1.1:1880/log?mac="$mac"'&'$1="$2")"
  result="$(getjsonresult $result 2)"
  echo "$result" 
}

 
  loggit state service_restart
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
    echo "test -=$(loggit state node-red_restart)=-"
    while [ -z $(loggit state node-red_restart) ] ; do
      
      #loggit state service_restart
      echo "waiting for node red to start"
      sleep 10
    done
    loggit state service_restarted
    
    
  ;;
  *)
    echo "cluster node"
  ;;
esac

while [ . ]; do

  for ((i=1;i<=50;i++)); 
  do
    getinfo 
    #check for defunct processes
      defunct="$(ps -A | grep "defunct")"
      if [ -n "$defunct" ]; then
        loggit state defunct_reboot
        loggit defunct_data "$defunct"
        echo 0 >/sys/class/leds/red_led/brightness
        #reboot
      fi
      
    #check to see if miner is running
    result="$(ps all | grep "..:[0-9][0-9] ./minerd" -o)"
    case "$result" in

      #is not running
      "")
        echo 0 >/sys/class/leds/red_led/brightness
        #echo "zero length"
        ./start.sh --workername $clusterNumber > /mining.log & pid="$!"
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
  
  oldClusterNumber="$clusterNumber"
  getinfo
  
  case "$oldClusterNumber" in
  "$clusterNumber")
    loggit state cluster_number_mismatch
    systemctl restart clusterMonitor
    exit 0
    sleep 30
  ;;
  *)
  ;;
  esac
  
 
  
  case $hostname in
  "cl-controller")
    echo 0 >/sys/class/leds/red_led/brightness
    clusterNumber="0"
    #reboot
  ;;
  esac
  
done
