#!/bin/bash
umount /imagemount
mount /dev/sda1 /imagemount
rm -v /imagemount/boot/* 
cp -v /imagemount/boot/sdcard_working/* /imagemount/boot/
ls /imagemount/boot

umount /imagemount
