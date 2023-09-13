{ config, pkgs, lib, fetchurl, ... }:

let
  java = true;
  rust = true;
  js = true;
  julia = true;

  docker = true;

  aws = true;
in
{
  nixpkgs.config.allowBroken = true;

  home.packages = with pkgs;
    lib.optionals js [ nodejs ]
    # ++ lib.optionals rust [ rustup /* rust-analyzer */ ]
    ++ lib.optionals rust [
    ]
    ++ lib.optionals java [ jdt-language-server maven jetbrains.jdk /* openjdk kotlin jetbrains.idea-community */ ]
    ++ lib.optionals julia [ julia-bin patchelf ]

    ++ lib.optionals docker [ pkgs.docker docker-compose ]
    ++ lib.optionals aws [ awscli2 ];
}
