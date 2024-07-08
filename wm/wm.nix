{ config
, pkgs
, lib
, ...
}:
let
  theming =
    (import ./theming.nix) { inherit config; inherit pkgs; inherit lib; };
    rofi-themes = (import ../pkgs/rofi-themes.nix) {
      theme = "catppuccin";
      style = 1;
      type = 4;
    };
in
{
  home.packages = (with pkgs; [
    xorg.xhost
    polkit

    # TODO: make this depend on a wayland variable

    mako

    foot
    hyprpaper
    rofi-themes
    slurp
    grim
    wl-clipboard
    copyq
    tmux
    libnotify
  ]);

  programs.rofi = {
    enable = true;
    configPath = ".config/rofi/config.rasi";
  };

  home.file = {
    # ".config/rofi/config.rasi" = {
    #   source = "${rofi-themes}/config.rasi";
    # };
    ".config/eww" = {
      source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixpkgs/eww";
      recursive = true;
    };
    ".config/electron-flags.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixpkgs/wm/electron-flags.conf";
    };
    # ".config/sway/config" = {
    #   source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixpkgs/wm/sway.config";
    # };
    # ".swaylock/config" = {
    #   source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixpkgs/wm/swaylock.config";
    # };
    ".config/hypr/hyprland.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixpkgs/wm/hyprland.conf";
    };
    ".config/hypr/hyprpaper.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixpkgs/wm/hyprpaper.conf";
    };
    ".config/rofi" = {
      source = rofi-themes;
      recursive = true;
    };
    "walls/catppuccin/train.jpg" = {
      source = pkgs.fetchurl {
        url = "https://github.com/flick0/dotfiles/blob/bc82ade2759ab172d15bcb506fe269f8f2adc435/config/hypr/wallpapers/train.jpg?raw=true";
        sha256 = "sha256-ICp9qB68PF73rOLaK5JkyqwvBZEG+ccH2ULngWKNBlk=";
      };
    };
    "walls/catppuccin/totoro.png" = {
      source = pkgs.fetchurl {
        url = "https://github.com/flick0/dotfiles/blob/bc82ade2759ab172d15bcb506fe269f8f2adc435/config/hypr/wallpapers/totoro.png?raw=true";
        sha256 = "sha256-L+WbPPYWWAlHfXV7UUDZpY7pNRQL/AhzNgXEMTaPf90=";
      };
    };
    "walls/catppuccin/flower.jpg" = {
      source = pkgs.fetchurl {
        url = "https://github.com/flick0/dotfiles/blob/bc82ade2759ab172d15bcb506fe269f8f2adc435/config/hypr/wallpapers/flower.jpg?raw=true";
        sha256 = "sha256-oAIYmdSsepcwh8NWhdwP3DnbOBo9EuJh1uOlTCCK49U=";
      };
    };
    "walls/nordic/nixos.png" = {
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/linuxdotexe/nordic-wallpapers/master/wallpapers/nixos.png";
        sha256 = "sha256-jB7q1PAMKS0tfk0Ck6pGkbsfwO+7FHwI83dUHO86ftM=";
      };
    };
  };
}

