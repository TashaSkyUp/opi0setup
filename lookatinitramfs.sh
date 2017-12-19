#!/bin/bash
umount /imagemount
mount /dev/sda1 /imagemount
mount /dev/mmcblk0p1 /imagemount

rm -r /myinitram
mkdir /myinitram

cp /imagemount/boot/initrd* /myinitram/initramfs.gz
cd /myinitram
gunzip initramfs.gz
mkdir image
cd image
cpio -vid < ../initramfs
