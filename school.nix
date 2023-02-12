{ config, pkgs, lib, ... }:

let
  school = true;

  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
if school then {
  home.packages = with unstable; [
    teams
    openscad
    wxmaxima

    hunspell
    unstable.hunspellDicts.nb-no
    unstable.hunspellDicts.en-gb-ize
    # libreoffice

    pandoc

    arduino
    arduino-cli
    go
    screen
    libsecret
    pkg-config
    xorg.libX11
    xorg.libxkbfile
    clang-tools
    electron
    appimage-run


    # python310
    # texlive.combined.scheme-full
    # (texlive.combine {
    #   inherit (texlive)
    #     scheme-medium
    #     svg transparent lipsum babel
    #     runcode morewrites tcolorbox environ
    #     xifthen ifmtarg framed paralist
    #     pythontex fvextra
    #     pgfplots
    #     enumitem
    #     apacite
    #     titlesec
    #     blindtext;
    # })
    libsForQt5.okular
    texlab
  ];
  programs.zsh.initExtra = ''
    source ~/Downloads/arduino.comp.zsh
  '';
} else { }
