#!/bin/bash
umount /imagemount
mount /dev/sda1 /imagemount
rm -v /imagemount/boot/* 
cp -v /imagemount/boot/backup/* /imagemount/boot/
ls /imagemount/boot

umount /imagemount
