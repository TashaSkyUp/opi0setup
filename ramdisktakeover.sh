#!/bin/bash
TOLINK=(
/proc
/sys
/dev
/dev/shm
/dev/pts
/etc
/lib
)

#info about what needs what to run

lnlinks="$(ldd $(command -v /bin/ln) |grep "/.*so" -o)"
echo "$lnlinks" > tmp && readarray test < tmp 

echo "lnlinks $test"
 for f in "${test[@]}";do
  echo "link: $f"
 done

exit 0

TARGETDIR="/takeover"
umount -f -v ./$TARGETDIR/ramdisk
sudo rm $TARGETDIR -r -f
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
  
  mount -t proc proc $TARGETDIR/proc
  mount -t sysfs sysfs $TARGETDIR/sys
  mount -t devtmpfs devtmpfs $TARGETDIR/dev
  mount -t tmpfs tmpfs $TARGETDIR/dev/shm
  mount -t devpts devpts $TARGETDIR/dev/pts
  
  echo "--= Copying root, bin, other files needed to survive =--"
  cp /root $TARGETDIR/root -r
  cp /bin $TARGETDIR/bin -r
  cp /lib/ld-linux-armhf.so.3 $TARGETDIR/lib
  cp /lib/arm-linux-gnueabihf/libc.so.6 $TARGETDIR/lib
  
  # Copy /etc/hosts
  /bin/cp -f /etc/hosts $TARGETDIR/etc/

  # Copy /etc/resolv.conf 
  /bin/cp -f /etc/resolv.conf $TARGETDIR/etc/resolv.conf

  # Link /etc/mtab
  chroot $TARGETDIR rm /etc/mtab 2> /dev/null 
  chroot $TARGETDIR ln -s /proc/mounts /etc/mtab
  
  
  exit 0
  chroot $TARGETDIR

