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
        "desktop-nixos"  = { id = "7CXLHNK-TRKPUAB-PG2LR75-LN7OKYM-4OUDPJK-X7OUFEX-XGYU7KM-74RBKQ2"; };
        "surface-nixos"  = { id = "YWUSM63-CYUUMAN-QQYTOW6-MPS7TDC-MIF5DRZ-XYBRVMU-2JGTUCY-7RWTVQM"; };
        "legion-nixos-2" = { id = "YMRLWWV-ECTKAUC-GLWZ7X7-KWGHQ7R-N3OSB7L-ZHKCDBH-BUZQHF6-4H7ZLA7"; };
        "iphone-xr-3"    = { id = "6CBBNBB-X4VC7GO-PNUKI32-B7EBALB-FOG42MG-N7HVZHS-JLB2EZN-HO3T7QS"; };
      };
      folders = {
        "nixpkgs" = {
          path = "/home/williams/.config/nixpkgs";
          devices = [ "desktop-nixos" "surface-nixos" "legion-nixos-2" ];
        };
      };
    };
  };
}
