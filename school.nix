
{ config, pkgs, lib, ... }:

let
  school = true;
in
  if school then {
    home.packages = [ pkgs.teams ];
  } else {}
