rfkill block bluetooth
rfkill unblock bluetooth

systemctl stop bluetooth.service
systemctl start bluetooth.service

bluetoothctl power on
bluetoothctl agent on
bluetoothctl default-agent
