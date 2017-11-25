#!/bin/bash

#first find cluster number and start mining
  mac="$(ifconfig |grep "wlan0" | grep "..:..:..:..:..:.." -o)"
  clusterNumber="$(curl 172.24.1.1:1880/opi0cluster?register="$mac" | cut -d',' -f 3 | cut -d':' -f2 | grep -o "[0-9]*")" 
  echo "$mac" > /mac
  echo "$clusterNumber" > /clusterNumber
  sleep 10
  cd /root/opi0setup/
  git pull
  ./start.sh --workername $clusterNumber > /mining.log &

while [ . ]; do
  clusterNumber="$(curl 172.24.1.1:1880/opi0cluster?register="$mac" | cut -d',' -f 3 | cut -d':' -f2 | grep -o "[0-9]*")" 
  echo "$clusterNumber" > /clusterNumber
  
  result="$(ps all | grep "..:[0-9][0-9] ./minerd" -o)"
  case "$result" in
    
    #is not running
    "")
      echo 0 >/sys/class/leds/red_led/brightness
      #echo "zero length"
      ./start.sh --workername $clusterNumber > /mining.log &
      ;;
    
    #is running
    *)
      #echo "non zero len"
      echo 255 >/sys/class/leds/red_led/brightness
      ;;

  esac

  sleep 10

done
