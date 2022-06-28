{ config, pkgs, lib, fetchurl, ... }:

let 
  java = true;
  rust = true;
  js   = true;

  docker = true;

  aws = true;
in 
  {
    home.packages = with pkgs;
         lib.optionals js   [ nodejs ]
      ++ lib.optionals rust [ rustup ]
      ++ lib.optionals java [ maven jetbrains.jdk /* openjdk */ kotlin jetbrains.idea-community ]

      ++ lib.optionals docker [ pkgs.docker docker-compose ]
      ++ lib.optionals aws    [ awscli2 ]; 

    home.file = {
      ".m2/settings.xml" = if java then { source = ./m2-settings.xml;} else {};
    };
  }
  # monoidMerge true {} 
  # (monoidMerge rust {}
  # (monoidMerge nodejs {} {}))


