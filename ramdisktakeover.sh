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

function findToArray {
	#cd /
	#echo "$1"
	#echo "$2"
	echo "$(find / -name "$1")" > tmp.tmp && readarray $2 < tmp.tmp
	rm tmp.tmp
	}
#info about what needs what to run

function copyLinksForCommand {
  echo "finding $1"
  findToArray $1 found
  echo "found $1 at $found. Copying to $2"
  cp found $2/bin
  
  echo "copying linked files for $1"
  lnlinks="$(ldd $(command -v $found) |grep "/.*so.* " -o)"
  
  echo "$lnlinks" > tmp && readarray test < tmp 
   for f in "${test[@]}";do
    echo "link: $f"
    cp $f $2/lib/ > null
   done
}

TARGETDIR="/takeover"
umount -f -v ./$TARGETDIR/ramdisk
sudo rm $TARGETDIR -r -f > null
mkdir $TARGETDIR
mkdir $TARGETDIR/ramdisk
mount -t ramfs -o size=256m ext4 $TARGETDIR/ramdisk
mount | grep ram



echo "Mount Kernel Virtual File Systems"
  TARGETDIR="/takeover/ramdisk"
  
  

  for i in "${TOLINK[@]}";do
    mkdir $TARGETDIR$i
  	echo $TARGETDIR$i
  done
  copyLinksForCommand /bin/ln $TARGETDIR
  copyLinksForCommand /root/opi0setup/wolfarmv7l/minerd $TARGETDIR
  copyLinksForCommand /bin/bash $TARGETDIR
  copyLinksForCommand /bin/ls $TARGETDIR
  copyLinksForCommand /bin/dirname $TARGETDIR
  copyLinksForCommand /bin/grep $TARGETDIR
  copyLinksForCommand /bin/cut $TARGETDIR
  copyLinksForCommand /bin/hostname $TARGETDIR
  copyLinksForCommand /bin/reboot $TARGETDIR
  
  

  
  mount -t proc proc $TARGETDIR/proc
  mount -t sysfs sysfs $TARGETDIR/sys
  mount -t devtmpfs devtmpfs $TARGETDIR/dev
  mount -t tmpfs tmpfs $TARGETDIR/dev/shm
  mount -t devpts devpts $TARGETDIR/dev/pts
  
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

