#!/bin/bash
umount /imagemount
mount /dev/sda1 /imagemount
mount /dev/mmcblk0p1 /imagemount

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

