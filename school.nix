
{ config, pkgs, lib, ... }:

let
  school = true;

  unstable = import <nixos-unstable> {};
in
  if school then {
    home.packages = with pkgs; [
      teams openscad wxmaxima

      hunspell unstable.hunspellDicts.nb-no unstable.hunspellDicts.en-gb-ize

      (texlive.combine {
        inherit (texlive)
          scheme-medium
          svg transparent lipsum babel
          pythontex
          runcode morewrites tcolorbox environ
          xifthen ifmtarg framed paralist
          enumitem
          apacite
          titlesec
          blindtext;
      })
      libsForQt5.okular
      texlab
    ];
  } else {}
