{ config, pkgs, lib, ... }:
let
  roles = {
    "project" = "Dev/Projects/";
    "micro-project" = "Dev/MicroProjects/";
    "script" = "Dev/Scripts/";

    "home" = "/";
  };

  repos = [
    {
      name = "x-tui";
      roles = [ "micro-project" ];
    }
    {
      name = "bridge-scad";
      roles = [ "micro-project" ];
    }
    {
      name = "obsidian-vault";
      roles = [ "home" ];
    }
  ];
in
{
  # home.files = lib.lists.fold
  #   (curr: acc:
  #     let
  #       src = pkgs.fetchFromGitHub {
  #         owner = "equilibris";
  #         repo = curr.name;
  #         rev = "master";

  #         fetchSubmodules = true;
  #         leaveDotGit = true;
  #       };
  #     in
  #     acc // { })
  #   { }
  #   repos;
}

