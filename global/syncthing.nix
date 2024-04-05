{ config, pkgs, ... }:
# https://nixos.wiki/wiki/Syncthing
{
  services.syncthing = {
    enable = true;

    # user = "williams";

    overrideDevices = true;
    overrideFolders = true;

    settings = {
      devices = {
        "desktop-nixos" = { id = "7CXLHNK-TRKPUAB-PG2LR75-LN7OKYM-4OUDPJK-X7OUFEX-XGYU7KM-74RBKQ2"; };
        "iphone-xr-3"   = { id = "6CBBNBB-X4VC7GO-PNUKI32-B7EBALB-FOG42MG-N7HVZHS-JLB2EZN-HO3T7QS"; };
      };
      # folders = {
      #   "nixpkgs" = {
      #     path = "/home/williams/.config/nixpkgs";
      #     devices = ["desktop-nixos"];
      #   };
      # };
    };
  };
}
