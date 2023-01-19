
{ config, pkgs, lib, ... }:

let
  school = true;

  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
  if school then {
    home.packages = with unstable; [
      teams openscad wxmaxima

      arduino

      hunspell unstable.hunspellDicts.nb-no unstable.hunspellDicts.en-gb-ize
      libreoffice

      pandoc

      python310
      (texlive.combine {
        inherit (texlive)
          scheme-medium
          svg transparent lipsum babel
          runcode morewrites tcolorbox environ
          xifthen ifmtarg framed paralist
          pythontex fvextra
          pgfplots
          enumitem
          apacite
          titlesec
          blindtext;
      })
      libsForQt5.okular
      texlab
    ];
  } else {}
