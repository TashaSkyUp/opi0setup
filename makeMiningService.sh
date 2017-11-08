execFile="/root/opi0setup/start.sh"
serviceName="mining.service"

serviceFile="[Unit]
Description=Default

[Service]
ExecStart=$execFile

[Install]
WantedBy=multi-user.target"

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
