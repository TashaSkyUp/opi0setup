#!/bin/bash
UUID="$(cat /proc/sys/kernel/random/uuid)"
echo "$UUID"
UUID_DAILY_HASH="$(echo "$UUID $(date)" | md5sum)"
echo "$UUID_DAILY_HASH"
RANDOM_MAC="dc:44:6d:$(echo -n ${UUID_DAILY_HASH} | sed 's/^\(..\)\(..\)\(..\).*$/\1:\2:\3/')"
echo "$RANDOM_MAC"
#exit 0
#ifconfig wlan0 down
#ifconfig wlan0 down
#nmcli connection down "ARMBIAN"
#nmcli connection down "ARMBIAN"

#macchanger -e -b wlan0
#nmcli connection modify "ARMBIAN" wifi.cloned-mac-address $RANDOM_MAC
echo "options xradio_wlan macaddr=${RANDOM_MAC^^}" > /etc/modprobe.d/xradio_wlan.conf

#nmcli connection modify "ARMBIAN" wifi.mac-address $RANDOM_MAC

#ifconfig wlan0 hw ether $RANDOM_MAC
#ifconfig wlan0 up


#nmcli connection up "ARMBIAN"
#ip link show



