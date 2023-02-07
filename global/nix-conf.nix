{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      neovim = super.neovim.override { vimAlias = true; };
    })
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];

    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
}
