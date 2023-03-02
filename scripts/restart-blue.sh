rfkill block bluetooth
rfkill unblock bluetooth

sudo systemctl restart bluetooth.service

bluetoothctl power on
bluetoothctl agent on
bluetoothctl default-agent
