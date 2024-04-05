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
        # "surface-nixos"  = { id = ""; };
        "iphone-xr-3"    = { id = "6CBBNBB-X4VC7GO-PNUKI32-B7EBALB-FOG42MG-N7HVZHS-JLB2EZN-HO3T7QS"; };
      };
      folders = {
        "nixpkgs" = {
          path = "/home/williams/.config/nixpkgs";
          devices = [ "desktop-nixos" ];
        };
      };
    };
  };
}
