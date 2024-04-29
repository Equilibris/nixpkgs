{ config, pkgs, lib, ... }:
# https://nixos.wiki/wiki/Syncthing
let
  main-devs = [
    "desktop-nixos" "surface-nixos" "legion-2-nixos"
  ];
  all-devs = main-devs ++ [ "iphone-xr-3" ];
in
{
  services.syncthing = {
    enable = true;

    user = "williams";
    dataDir = "/home/williams";

    overrideDevices = true;
    overrideFolders = true;

    settings = {
      devices = {
        "desktop-nixos"  = { id = "X2H23T6-BNUWUVM-4DDJCUV-YUFUMEK-ZR6QHVR-IEVQVQY-JR3ODWH-CPDWNQN"; };
        "surface-nixos"  = { id = "S5Y7MO7-XVDGA7G-BVPMCIB-72KV3YJ-F3JCFK2-ASSHXSF-6QVRKZC-E6PKDAW"; };
        "legion-2-nixos" = { id = "HUULIFN-JOTPBAP-ZCP2B6W-VUV3DMU-RYLBTCB-367WM6Z-AHLPYCE-YPEKRQE"; };
        "iphone-xr-3"    = { id = "SADIUKA-A45F35D-A2RGBOU-4Q6QXUE-4SAU5XR-SK263OS-4S7XBFX-F7GF3QO"; };
      };
      folders = {
        "nixpkgs" = {
          path = "/home/williams/.config/nixpkgs";
          devices = main-devs;
        };
        "dev" = {
          path = "/home/williams/Dev";
          devices = main-devs;
        };
        "scriptable" = {
          path = "/home/williams/Dev/MicroProjects/Scriptable";
          devices = all-devs;
        };
        "obsidian" = {
          path = "/home/williams/obsidian-vault";
          devices = all-devs;
        };
      };
    };
  };
}
