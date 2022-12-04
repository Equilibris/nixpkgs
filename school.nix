
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
          runcode morewrites tcolorbox environ
          xifthen ifmtarg framed paralist
          enumitem
          apacite
          titlesec
          blindtext;

       maxiplot = { pkgs = [(pkgs.runCommand "maxiplot" {
         src = pkgs.fetchurl {
           url = "https://maxima.sourceforge.io/contrib/maxiplot/maxiplot.sty";
           sha256 = "sha256-S9NUKd0J7CokxHHcMAiIa8ZoN52R8bGwKaVVc0hWa74=";
         };
         passthru = {
           pname = "maxiplot";
           version = "1.2.3";
           tlType = "run";
         };
       }
         "
           mkdir -p $out/tex/latex/maxiplot/
           cp $src $out/tex/latex/maxiplot/maxiplot.sty
           ")];
        };
      })
      libsForQt5.okular
      texlab
    ];
  } else {}
