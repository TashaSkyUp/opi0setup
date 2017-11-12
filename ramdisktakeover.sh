rm takeover -r
mkdir takeover
mkdir takeover/ramdisk
mount -t ramfs -o size=256m ext4 ./takeover/ramdisk
mount | grep ram
