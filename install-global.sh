DATE=$(date +%F)
BACKUP="/etc/nixos/backup-$DATE"

CONFIGS="/home/williams/.config/nixpkgs"
GLOBALS="$CONFIGS/global"

sudo mkdir $BACKUP
sudo mv /etc/nixos/*.nix $BACKUP

ls -1 $GLOBALS | while read line; do sudo ln "$GLOBALS/$line" "/etc/nixos/$line"; done

sudo ln "$CONFIGS/flake.nix"  "/etc/nixos/flake.nix"
sudo ln "$CONFIGS/flake.lock" "/etc/nixos/flake.lock"

OPTION=$(echo "$(ls -1 "$GLOBALS/hardware-configuration")
new" | fzf)

if [ $OPTION = new ]
then
    cp "$BACKUP/hardware-configuration.nix" "$GLOBALS/hardware-configuration/hardware-configuration.new.nix"
    sudo ln "$GLOBALS/hardware-configuration/hardware-configuration.new.nix" "/etc/nixos/hardware-configuration.nix"
else
    sudo ln "$GLOBALS/hardware-configuration/$OPTION" "/etc/nixos/hardware-configuration.nix"
fi

