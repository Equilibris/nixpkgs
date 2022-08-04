# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix") ];


  environment.systemPackages = [ (import ./create-randr.nix [
    {
      output = "DP-1";
      x = 1920;
      y = 0;
    }
    {
      output = "HDMI-A-1";
      x = 3840;
      y = 0;
    }
    {
      output = "DP-2";
      x = 0;
      y = 0;
    }
  ] {}) ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/77338c28-23e8-4bbb-b6db-45bf4002dd67";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/F61A-5883";
      fsType = "vfat";
    };

  sound.extraConfig = 
    ''
      @hooks [
          {
              func load
              files [
                  "~/.asoundrc"
              ]
              errors false
          }
      ]
      pcm.!default {
        type hw
        card "Wireless"
      }
      ctl.!default {
        type hw
        card "Wireless"
      }
    '';

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
