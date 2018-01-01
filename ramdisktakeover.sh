#!/bin/bash
TOLINK=(
/proc
/sys
/dev
/dev/shm
/dev/pts
/etc
/lib
/bin
)
SKIPSERVICES=""

function lfListToArray {
	echo "$1" > tmp.tmp
	a="$(cat tmp.tmp | grep ".*" -o)"
	echo "$a" > tmp.tmp
	readarray $2 < tmp.tmp	
}
function echoArray {
	tmp="$1"
	for s in "${tmp[@]}"
	do
	echo -n "$s"
	
	done
}
function stopAllServices {
	#lfListToArray "$(systemctl | grep "[a-Z].*\(service\)\*\(\target\)\*" -o)" srvs
	#lfListToArray "$(systemctl | grep "[a-Z].*\(service|target\)*" -o)" srvs && echo "${srvs[52]}"
	lfListToArray "$(systemctl | grep ".*\.\(service\|target\)" -o)" srvs && echo "${srvs[52]}"
	
	for s in "${srvs[@]}"
	do
		case $s in

		$SKIPSERVICES)
			echo -n "skipping: $s"	
		;;
		*)
			echo -n "stopping: $s"
			#systemctl stop $s
		;;
		esac
	done

}

function startAllServices {
	#lfListToArray "$(systemctl | grep "[a-Z].*service" -o)" srvs
	for s in "${srvs[@]}"
	do
	echo -n "$s"
	systemctl start $s
	done

}


function findToArray {
	rm -f tmp.tmp
	echo "$(find /bin      -executable -xtype f -name "$1")" >> tmp.tmp
	echo "$(find /sbin     -executable -xtype f -name "$1")" >> tmp.tmp
	echo "$(find /usr/bin  -executable -xtype f -name "$1")" >>  tmp.tmp
	echo "$(find /usr/sbin -executable -xtype f -name "$1")" >>  tmp.tmp
	echo "$(find ~         -executable -xtype f -name "$1")" >> tmp.tmp

	a="$(cat tmp.tmp | grep ".*" -o)"
	echo "$a" > tmp.tmp
	readarray $2 < tmp.tmp
	rm tmp.tmp
	}
#info about what needs what to run

function copyLinksForCommand {
	echo " "
	echo " -= finding $1 =- "
	findToArray $1 found
	found="$(echo "${found[0]}" | sed 's/[[:space:]]//g')"
	echo "found $1 at $found; Copying it to $2"
	cp ${found[0]} $2/bin

	echo "copying linked files for $1"
	lnlinks="$(ldd $(command -v ${found[0]}) |grep "/.*so.* " -o)"

	echo "$lnlinks" > tmp && readarray test < tmp 
	for f in "${test[@]}";do
		echo -n "    link: $f"
		cp $f $2/lib/ > null
	done
}

systemctl stop clusterMonitor
TARGETDIR="/takeover"

umount -f -v $TARGETDIR/ramdisk/dev/shm
umount -f -v $TARGETDIR/ramdisk/dev/pts
umount -f -v $TARGETDIR/ramdisk/proc
umount -f -v $TARGETDIR/ramdisk/sys
umount -f -v $TARGETDIR/ramdisk/dev
umount -f -v $TARGETDIR/ramdisk

sudo rm $TARGETDIR -r -f > null
mkdir $TARGETDIR
mkdir $TARGETDIR/ramdisk
mount -t ramfs -o size=128m ext4 $TARGETDIR/ramdisk
mount | grep ram



echo "Mount Kernel Virtual File Systems"
  TARGETDIR="/takeover/ramdisk"
  
  for i in "${TOLINK[@]}";do
    mkdir $TARGETDIR$i
  	echo $TARGETDIR$i
  done
  copyLinksForCommand ln $TARGETDIR
  copyLinksForCommand minerd $TARGETDIR
  copyLinksForCommand bash $TARGETDIR
  copyLinksForCommand ls $TARGETDIR
  copyLinksForCommand dirname $TARGETDIR
  copyLinksForCommand grep $TARGETDIR
  copyLinksForCommand cut $TARGETDIR
  copyLinksForCommand hostname $TARGETDIR
  copyLinksForCommand reboot $TARGETDIR
  copyLinksForCommand sudo $TARGETDIR
  copyLinksForCommand htop $TARGETDIR
  copyLinksForCommand sudo $TARGETDIR
  copyLinksForCommand mount $TARGETDIR
  copyLinksForCommand umount $TARGETDIR
  copyLinksForCommand sshd $TARGETDIR
  copyLinksForCommand script $TARGETDIR
  copyLinksForCommand ifconfig $TARGETDIR
  copyLinksForCommand nmtui $TARGETDIR
  copyLinksForCommand nmcli $TARGETDIR
  
  mount  -t proc proc $TARGETDIR/proc
  umount -f /proc
  
  mount -t sysfs sysfs $TARGETDIR/sys
  umount -f /sys

  mount -t devtmpfs devtmpfs $TARGETDIR/dev
  mount -t tmpfs tmpfs       $TARGETDIR/dev/shm  
  mount -t devpts devpts     $TARGETDIR/dev/pts
  umount -f /dev/shm
  umount -f /dev/pts
  umount -f /dev
  
  echo "--= Copying root, bin, other files needed to survive =--"
  cp /root $TARGETDIR/root -r
  cp /bin $TARGETDIR/ -r
  cp /lib/ld-linux-armhf.so.3 $TARGETDIR/lib
  cp /lib/arm-linux-gnueabihf/libc.so.6 $TARGETDIR/lib
  
  # Copy /etc/hosts
  /bin/cp -f /etc/hosts $TARGETDIR/etc/

  # Copy /etc/resolv.conf 
  /bin/cp -f /etc/resolv.conf $TARGETDIR/etc/resolv.conf

  # Link /etc/mtab
  chroot $TARGETDIR rm /etc/mtab 2> /dev/null 
  chroot $TARGETDIR ln -s /proc/mounts /etc/mtab
  
  
  #exit 0
  chroot $TARGETDIR

