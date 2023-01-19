# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./wm.nix
      <home-manager/nixos>
    ];

  # boot.shell_on_fail = true;
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };

    grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        # splashImage = /home/williams/walls/nordic/nixos.png;
        theme =
          pkgs.stdenv.mkDerivation {
            pname = "distro-grub-themes";
            version = "3.1";
            src = pkgs.fetchFromGitHub {
              owner = "TechXero";
              repo = "XeroNord-Grub";
              rev = "96912ebf601e31ae32fd3871361d26d11fa9f9b6";
              hash = "sha256-Q/uHWoajKvnTueqSbH5UtdUuK9Z3l/ELqF41jNaQmYE=";
            };
            installPhase = "cp -r XeroNord $out";
          };
          # pkgs.stdenv.mkDerivation {
          #   pname = "distro-grub-themes";
          #   version = "3.1";
          #   src = pkgs.fetchFromGitHub {
          #     owner = "13atm01";
          #     repo = "GRUB-Theme";
          #     rev = "02a3e4233e0b2852a310dc9165097ae9ccf3b2c8";
          #     hash = "sha256-rIpRP5+5Z8tIet6/1/8rB2NFgofUhJVgNhezf7jdRgA=";
          #   };
          #   # installPhase = "cp -r \"Monika (Doki Doki Literature Club)/Monika-DDLC-Version\" $out";
          #   installPhase = "cp -r \"Artoria Pendragon (15th Celebration Version)/Artoria-Celebration-Version\" $out";
          # };

          # pkgs.stdenv.mkDerivation {
          #   pname = "distro-grub-themes";
          #   version = "3.1";
          #   src = pkgs.fetchFromGitHub {
          #     owner = "AdisonCavani";
          #     repo = "distro-grub-themes";
          #     rev = "v3.1";
          #     hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
          #   };
          #   installPhase = "cp -r customize/nixos $out";
          # };

      extraEntries = ''
        menuentry 'Windows Boot Manager (on /dev/nvme0n1p1)' --class windows --class os $menuentry_id_option 'osprober-efi-F8FD-D8E5' {
            insmod part_gpt
            insmod fat
            search --no-floppy --fs-uuid --set=root F8FD-D8E5
            chainloader /efi/Microsoft/Boot/bootmgfw.efi
        }
      '';
    };
  };
  boot.kernelPackages = unstable.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.firewall.enable = false;
  networking.firewall.allowedTCPPortRanges = [
    { from = 18999; to = 19003; }
  ];

  # services.gpg-agent.enable = true;
  services.pcscd.enable = true;


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager = {
    enable = true;

    wifi.scanRandMacAddress = false;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    git gh
    firefox
    kitty neovim
  ];

  environment.variables.EDITOR = "nvim";
  nixpkgs.overlays = [
    (self: super: {
      neovim = super.neovim.override { vimAlias = true; };
    })
  ];

  # programs.home-manager.enable = true;

  programs.zsh.enable = true;
  programs.light.enable = true;

  security.sudo.extraRules = [
    { users = [ "williams" ]; runAs = "root";
      commands =
        [ { command = "/run/current-system/sw/bin/light"; options = [ "NOPASSWD" ]; } ]; }
      ];

  ###########################################################
  ###################### AUDIO ##############################
  ###########################################################

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  # programs.dconf.enable = true;

  # hardware.pulseaudio.enable = true;
  # # Enable sound with pipewire.
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  ###########################################################
  ###################### USERS ##############################
  ###########################################################

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.utf8";

  # Configure console keymap
  console = {
    keyMap = "no";
    colors = [
      "002b36" ### 01 ### 0 & 1
      "dc322f" ### 02 ### 2
      "859900" ### 03 ### 3
      "b58900" ### 04 ### 4
      "268bd2" ### 05 ### 5
      "d33682" ### 06 ### 6
      "2aa198" ### 07 ### 7
      "eee8d5" ### 08 ### 8
      "002b36" ### 01
      "cb4b16" ### 10
      "586e75" ### 11
      "657b83" ### 12
      "839496" ### 13
      "6c71c4" ### 14
      "93a1a1" ### 15
      "fdf6e3" ### 16
    ];
    # colors = [ 002b36-dc322f-859900-b58900-268bd2-d33682-2aa198-eee8d5-002b36-cb4b16-586e75-657b83-839496-6c71c4-93a1a1-fdf6e3-];
    # colors = [
    #   "FF0000"
    #   "FF0000"
    #   "FF0000"
    #   "FF0000"
    #   "FF0000"
    #   "FF0000"
    #   "00FF00"
    #   "00FF00"
    #   "00FF00"
    #   "00FF00"
    #   "00FF00"
    #   "00FF00"
    #   "00FF00"
    #   "0000FF"
    #   "0000FF"
    #   "0000FF"
    #   "0000FF"
    # ];
    # colors = [
    #   "0000FF"
    #   "0000FF"
    #   "0000FF"
    #   "0000FF"
    #   "FF0000"
    #   "FF0000"
    #   "FF0000"
    #   "00FF00"
    #   "00FF00"
    #   "00FF00"
    #   "FF0000"
    #   "FF0000"
    #   "FF0000"
    #   "00FF00" 
    #   "00FF00"
    #   "00FF00"
    #   "00FF00"
    # ];
    # colors = [
    #   "2E3440"
    #   "3B4252"
    #   "434C5E"
    #   "4C566A"
    #   "D8DEE9"
    #   "E5E9F0"
    #   "ECEFF4"
    #   "8FBCBB"
    #   "88C0D0"
    #   "81A1C1"
    #   "5E81AC"
    #   "BF616A"
    #   "D08770"
    #   "EBCB8B"
    #   "A3BE8C"
    #   "B48EAD"
    # ];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.williams = {
    isNormalUser = true;
    description = "William Sørensen";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
  # virtualisation.docker.enable = true;

  # console = {
  #   earlySetup = true;
  #   font = "FiraCode Nerd Font";
  #   packages = [ (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; }) ];
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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
  system.stateVersion = "22.05"; # Did you read the comment?
}
