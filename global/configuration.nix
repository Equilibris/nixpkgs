# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, unstable, ... }:

{
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    git
    kitty
    neovim
    polkit

    ntfs3g

    cachix

    openssl

    libimobiledevice
    ifuse

    pinentry-curses

    qemu
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  environment.variables.EDITOR = "nvim";
  environment.variables.GDK_BACKEND = "x11";

  # programs.home-manager.enable = true;

  programs.zsh.enable = true;
  programs.light.enable = true;

  security.sudo.extraRules = [
    {
      users = [ "williams" ];
      runAs = "root";
      commands =
        [{ command = "/run/current-system/sw/bin/light"; options = [ "NOPASSWD" ]; }];
    }
  ];

  # programs.gnugp.agent.enable = true;
  # services.gpg-agent.enable = true;
  services.pcscd.enable = true;
  services.fwupd.enable = true;
  security.polkit.enable = true;
  services.qemuGuest.enable = true;
  services.usbmuxd =
    {
      enable = true;
      package = pkgs.usbmuxd2;
    };
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
    enableSSHSupport = true;
  };

  zramSwap.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leavecatenate(variables, "bootdev", bootdev)
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
