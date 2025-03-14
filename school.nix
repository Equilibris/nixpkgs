{ config, pkgs, lib, ... }:

let
  school = true;
in
if school then {
  home.packages = with pkgs; [
    # hunspell
    # hunspellDicts.nb-no
    # hunspellDicts.en-gb-ize
    # pandoc

    texlive.combined.scheme-medium
    swiProlog
    screen
    libsecret
    libreoffice
    blender
    remnote
    pkg-config
    xorg.libX11
    xorg.libxkbfile
    clang-tools
    # electron

    # libsForQt5.okular
  ];
} else { }
