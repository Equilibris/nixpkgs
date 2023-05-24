{ config, pkgs, lib, fetchurl, ... }:

let
  java = false;
  rust = false;
  js = true;
  julia = true;

  docker = true;

  aws = true;
in
{
  nixpkgs.config.allowBroken = true;

  home.packages = with pkgs;
    lib.optionals js [ nodejs ]
    ++ lib.optionals rust [ rustup ]
    ++ lib.optionals java [ maven jetbrains.jdk /* openjdk */ kotlin jetbrains.idea-community ]
    ++ lib.optionals julia [ julia-bin patchelf ]

    ++ lib.optionals docker [ pkgs.docker docker-compose ]
    ++ lib.optionals aws [ awscli2 ];
}
# monoidMerge true {} 
# (monoidMerge rust {}
# (monoidMerge nodejs {} {}))


