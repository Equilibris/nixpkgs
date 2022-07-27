{ config, pkgs, lib, ... }:

{
  home.packages = [ pkgs.spotify-tui pkgs.spotify ];
}

