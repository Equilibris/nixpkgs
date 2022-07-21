{ config
, pkgs
, lib
, ... }:
{
  home.packages = (with pkgs; [ 
    rofi
    slurp grim
    wl-clipboard copyq
    tmux
    fnott libnotify
  ]);

  home.file = {
    ".config/eww" = {
      source = ../eww;
      recursive = true;
    };
    ".config/sway/config" = {
      source = config.lib.file.mkOutOfStoreSymlink ./sway.config;
    };
    ".config/fnott/fnott.ini" = {
      source = config.lib.file.mkOutOfStoreSymlink ./fnott.ini;
    };
    "walls/nordic/nixos.png" = {
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/linuxdotexe/nordic-wallpapers/master/wallpapers/nixos.png";
        sha256 = "sha256-jB7q1PAMKS0tfk0Ck6pGkbsfwO+7FHwI83dUHO86ftM=";
      };
    };
  };
}

