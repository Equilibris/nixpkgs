{ config, pkgs, ... }:

{
  networking = {
    hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # networking.networkmanager.enable = true;  # Enables wireless support via wpa_supplicant.

    firewall.enable = true;
    firewall.allowedTCPPorts = [
      # 8384 # Syncthing UI DO NOT ENABLE
      22000 # Syncthing sync
      25565 # Minecraft

      # Expo
      8080
      8081
      19000
      19001
      19002
      19003
    ];
    firewall.allowedUDPPorts = [
      22000
      21027
      25565 # Minecraft

      # Expo
      8080
      19000
      19001
      19002
      19003
    ];
    # firewall.allowedTCPPortRanges = [
    #   { from = 18999; to = 19003; }
    # ];

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    # wireless.enable = false;
    networkmanager = {
      enable = true;

      wifi.scanRandMacAddress = false;
    };
  };
}

