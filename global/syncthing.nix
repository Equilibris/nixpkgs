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
        "desktop-nixos"  = { id = "5GRSIJD-FI5UDWH-5SP43RH-DHILVXH-FZJWEZP-J5QLNQH-3CDCIU4-6YJTZQQ"; };
        "surface-nixos"  = { id = "FRLZVQB-AXZSGVG-YL75SHD-FBOJIIN-JUSYIR7-6I62X33-P4BMULB-FWEKFQI"; };
        "legion-2-nixos" = { id = "DHPK3L7-YESLDGL-ND5BSKS-EEC3SM2-DK5XCFW-H7KUU2D-QHWJ26Y-GAO2XQK"; };
        "iphone-xr-3"    = { id = "6CBBNBB-X4VC7GO-PNUKI32-B7EBALB-FOG42MG-N7HVZHS-JLB2EZN-HO3T7QS"; };
      };
      folders = {
        "nixpkgs" = {
          path = "/home/williams/.config/nixpkgs";
          devices = [ "desktop-nixos" "surface-nixos" "legion-2-nixos" ];
        };
        "dev" = {
          path = "/home/williams/Dev";
          devices = [ "desktop-nixos" "surface-nixos" "legion-2-nixos" ];
        };
        "obsidian" = {
          path = "/home/williams/obsidian-vault";
          devices = [ "desktop-nixos" "surface-nixos" "legion-2-nixos" ];
        };
      };
    };
  };
}
