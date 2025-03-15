{ config, pkgs, lib, ... }:

let
  school = true;
in
if school then {
  home.packages = with pkgs; [

    screen
    libsecret
    libreoffice
    # blender
    remnote
    pkg-config
    xorg.libX11
    xorg.libxkbfile
    # electron

    # libsForQt5.okular
  ];
} else { }
