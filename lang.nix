{ config, pkgs, ... }:

let 
  java = false;
  rust = true;
  js   = true;
in 
  {
    home.packages = with pkgs;
         lib.optionals js   [ nodejs ]
      ++ lib.optionals rust [ rustup ]
      ++ lib.optionals java [ maven openjdk17 kotlin ];
  }
  # monoidMerge true {} 
  # (monoidMerge rust {}
  # (monoidMerge nodejs {} {}))


