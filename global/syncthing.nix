{ config, pkgs, lib, ... }:
# https://nixos.wiki/wiki/Syncthing
{
  services.syncthing = {
    enable = true;

    user = "williams";
    dataDir = "/home/williams";

    overrideDevices = true;
    overrideFolders = true;

    settings = {
      devices = {
        "desktop-nixos" = { id = "X2H23T6-BNUWUVM-4DDJCUV-YUFUMEK-ZR6QHVR-IEVQVQY-JR3ODWH-CPDWNQN"; };
        "surface-nixos" = { id = "S5Y7MO7-XVDGA7G-BVPMCIB-72KV3YJ-F3JCFK2-ASSHXSF-6QVRKZC-E6PKDAW"; };
      };
      folders = {
        "nixpkgs" = {
          path = "/home/williams/.config/nixpkgs";
          devices = [
            "desktop-nixos" "surface-nixos" # "legion-2-nixos"
          ];
        };
        "dev" = {
          path = "/home/williams/Dev";
          devices = [
            "desktop-nixos" "surface-nixos" # "legion-2-nixos"
          ];
        };
        "obsidian" = {
          path = "/home/williams/obsidian-vault";
          devices = [
            "desktop-nixos"
            "surface-nixos"
            # "legion-2-nixos"
            # "iphone-xr-3"
          ];
        };
      };
    };
  };
}
