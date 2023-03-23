{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [ spotify-tui spotifyd ];
}

