$TARGETDIR="takeover"
rm $TARGETDIR -r
mkdir $TARGETDIR
mkdir $TARGETDIR/ramdisk
mount -t ramfs -o size=256m ext4 ./$TARGETDIR/ramdisk
mount | grep ram

# Mount Kernel Virtual File Systems

mount -t proc proc $TARGETDIR/proc
mount -t sysfs sysfs $TARGETDIR/sys
mount -t devtmpfs devtmpfs $TARGETDIR/dev
mount -t tmpfs tmpfs $TARGETDIR/dev/shm
mount -t devpts devpts $TARGETDIR/dev/pts

# Copy /etc/hosts
/bin/cp -f /etc/hosts $TARGETDIR/etc/

# Copy /etc/resolv.conf 
/bin/cp -f /etc/resolv.conf $TARGETDIR/etc/resolv.conf

# Link /etc/mtab
chroot $TARGETDIR rm /etc/mtab 2> /dev/null 
chroot $TARGETDIR ln -s /proc/mounts /etc/mtab
