# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

let unstable = import <nixos-unstable> { config = { allowUnfree = true; }; }; in
{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/ec7730ce-a750-41f7-836b-2b97414fab37";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    {
      device = "/dev/disk/by-uuid/8A71-F1B4";
      fsType = "vfat";
    };

  swapDevices = [ ];

  # NVIDIA drivers are unfree.
  nixpkgs.config.allowUnfree = true;

  services.xserver.videoDrivers = [ "nvidia" "modesetting" "iwlwifi" ];
  hardware.nvidia = {
    # package = config.boot.kernelPackages.nvidiaPackages.stable;

    # open = true;
    powerManagement.enable = true;

    modesetting.enable = true;
  };
  hardware.opengl.enable = true;

  environment.etc = {
    # Creates /etc/nanorc
    "modprobe.d/iwlwifi.conf" = {
      # https://bbs.archlinux.org/viewtopic.php?id=257739
      text = ''
        options iwlwifi 11n_disable=1
        options iwlwifi swcrypto=0
        options iwlwifi bt_coex_active=0
        options iwlwifi power_save=0
        options iwlwifi uapsd_disable=1

        options iwlmvm power_scheme=1
      '';

      # The UNIX file mode bits
      mode = "0444";
    };
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
