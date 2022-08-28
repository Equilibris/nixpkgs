{ config
, pkgs
, lib
, ... }:
let rofi-themes = import ../pkgs/rofi-themes.nix {}; in
{
  home.packages = (with pkgs; [ 
    xorg.xhost polkit

    rofi rofi-themes
    slurp grim
    wl-clipboard copyq
    tmux
    fnott libnotify
    (import ../pkgs/eww.nix {})
  ]);

  home.file = {
    ".config/eww" = {
      source = ../eww;
      recursive = true;
    };
    ".config/sway/config" = {
      source = config.lib.file.mkOutOfStoreSymlink ./sway.config;
    };
    ".swaylock/config" = {
      source = config.lib.file.mkOutOfStoreSymlink ./swaylock.config;
    };
    ".config/fnott/fnott.ini" = {
      source = config.lib.file.mkOutOfStoreSymlink ./fnott.ini;
    };
    # ".config/rofi" = {
    #   source = rofi-themes;
    #   recursive = true;
    # };
    "walls/nordic/nixos.png" = {
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/linuxdotexe/nordic-wallpapers/master/wallpapers/nixos.png";
        sha256 = "sha256-jB7q1PAMKS0tfk0Ck6pGkbsfwO+7FHwI83dUHO86ftM=";
      };
    };
  };
}

