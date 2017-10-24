#!/bin/bash
# list device holding current system root
awk '$2=="/"{print $1}' /proc/mounts

a=$"#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &"
xs=$"/root/.vnc/xstartup"
apt install xfce4 xfce4-goodies tightvncserver xfonts-base network-manager-gnome -y
vncserver
echo "doing 1"
apt install synaptic -y
apt update -y
apt upgrade -y
vncserver -kill :1
mv ~/.vnc/xstartup $xs
echo "doing 2"
echo "$a" |tee $xs
cat ~/.vnc/xstartup
chmod +x $xs