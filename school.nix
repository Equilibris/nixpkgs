
{ config, pkgs, lib, ... }:

let
  school = true;
in
  if school then {
    home.packages = with pkgs; [
      teams openscad wxmaxima

      (texlive.combine {
        inherit (texlive)
          scheme-medium
          runcode morewrites tcolorbox environ utf8x
          xifthen ifmtarg framed paralist
          titlesec
          blindtext;
      })
      libsForQt5.okular
      texlab
    ];
  } else {}
