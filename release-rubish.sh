nix-env --delete-generations 1d
home-manager expire-generations 0
sudo nix-collect-garbage -d
sudo nix-collect-garbage
sudo nix-store --optimize

