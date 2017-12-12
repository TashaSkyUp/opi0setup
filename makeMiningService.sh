execFile="/root/opi0setup/clusterMonitor.sh"
execOpts=" > /clusterMonitor.log"
serviceName="clusterMonitor.service"

serviceFile="[Unit]
Description=Default

[Service]
ExecStart=$execFile$execOpts &

[Install]
WantedBy=multi-user.target"

#git pull
git pull

#Place it in /etc/systemd/system folder with say a name of myfirst.service
echo "$serviceFile" > /etc/systemd/system/$serviceName

#Make that your script executable with:
chmod u+x $execFile

#Start it:
sudo systemctl start $serviceName
#Enable it to run at boot:
sudo systemctl enable $serviceName
#Stop it:
sudo systemctl stop $serviceName

systemctl restart $serviceName
