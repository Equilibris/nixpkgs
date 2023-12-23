{ config, pkgs, ... }:
if false then
  {
    services.usbmuxd.enable = true;

    environment.systemPackages = with pkgs; [
      libimobiledevice
      ifuse # optional, to mount using 'ifuse'
    ];
    services.usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };
  } else { }
