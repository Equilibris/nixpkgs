ls -1 ~/.config/nixpkgs/global | while read line; do sudo ln "global/$line" "/etc/nixos/$line"; done

