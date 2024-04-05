{ config, pkgs, ... }:
# https://nixos.wiki/wiki/Syncthing
{
  services.syncthing = {
    enable = true;

    user = "williams";

    overrideDevices = true;
    overrideFolders = true;

    settings = {
      devices = {
        "desktop-nixos" = { id = "7CXLHNK-TRKPUAB-PG2LR75-LN7OKYM-4OUDPJK-X7OUFEX-XGYU7KM-74RBKQ2"; };
      };
      folders = {
        "nixpkgs" = {
          path = "/home/williams/.config/nixpkgs";
          devices = ["desktop-nixos"];
        };
      };

      gui = {
        user = "williams";
        # Never allow this port on firewall
        password = "firewall_is_enabled";
      };
    };
  };
}
