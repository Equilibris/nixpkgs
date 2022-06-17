ls -1 ~/.config/nixpkgs/global | while read line; do sudo cp "~/.config/nixpkgs/global/$line" "/etc/nixos/$line"; done

