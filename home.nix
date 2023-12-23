{ config, pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugins
    qt5.qtwayland
    xdg-utils
    xorg.xprop

    unzip
    bat
    htop
    discord
    git
    gh
    git-secret

    glib

    # teams

    gcc
    # stdenv.cc.cc.lib clang libcxx libcxxabi clang.bintools clang.bintools

    obsidian

    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    # XDG_CURRENT_DESKTOP = "sway";
  };

  # home.sessionPath = [ "$HOME/.npm-global/bin" ];

  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 59.9;
    longitude = 10.7;
  };

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;

    theme.name = "Nordic";
    theme.package = pkgs.nordic;

    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  programs.git = {
    enable = false;
    userName = "William Sørensen";
    userEmail = "47296141+Equilibris@users.noreply.github.com";
    extraConfig = {
      init.defaultBranchName = "main";
      safe.directory = "*";
    };
  };
}
