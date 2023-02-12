{ config
, pkgs
, lib
, ...
}:
let
  rofi-themes = import ../pkgs/rofi-themes.nix {
    theme = "nord";
    style = 15;
    type = 1;
  };
  unstable = import <nixos-unstable> { };
in
{
  home.packages = (with pkgs; [
    xorg.xhost
    polkit

    mako

    rofi-themes
    slurp
    grim
    wl-clipboard
    copyq
    tmux
    fnott
    libnotify
    (unstable.eww-wayland)
  ]);

  programs.rofi = {
    enable = true;
    package = unstable.rofi;
    configPath = ".config/rofi/config.rasi";
  };

  home.file = {
    ".config/rofi/config.rasi" = {
      source = "${rofi-themes}/config.rasi";
    };
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
    ".config/hypr/hyprland.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink ./hyprland.conf;
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

