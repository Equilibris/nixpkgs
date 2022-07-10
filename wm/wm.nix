{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [ rofi eww ];

  nixpkgs.overlays = [
    (self: super: {
      eww = super.eww.override { withWayland = true; };
    })
  ];

  home.file = {
    ".config/sway/config" = {
      source = ./sway.config;
    };
    "walls/nordic/nixos.png" = {
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/linuxdotexe/nordic-wallpapers/master/wallpapers/nixos.png";
        sha256 = "sha256-jB7q1PAMKS0tfk0Ck6pGkbsfwO+7FHwI83dUHO86ftM=";
      };
    };
  };
}

