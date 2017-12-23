#!/bin/bash
if [ -z "$(mount | grep "/imagemount")" ]; then
echo "/imagemount not mounted yet"
else
umount /imagemount
fi

if [ -e /dev/sda1 ]; then
mount /dev/sda1 /imagemount
else
mount /dev/mmcblk0p1 /imagemount
fi

rm -r /myinitram
mkdir /myinitram
mkdir /myinitram/image

cp /imagemount/boot/initrd* /myinitram/image/initramfs.gz
cd /myinitram/image
gunzip initramfs.gz
#mkdir image
#cd image

cd ..
cpio -vid < ./image/initramfs

find . -name "*bear*"
find . -name "*xr*"
find . -name "*host*"
find . -name "*ifconfig*"
find . -name "*my*"
find . -name "*passwd*"

