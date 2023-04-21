{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs =
    { self
    , nixpkgs
    , hyprland
    , home-manager
    , nur
    , nixos-hardware
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations.williams = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          nur.nixosModules.nur
          {
            home.stateVersion = "22.11";
            home.username = "williams";
            home.homeDirectory = "/home/williams";
          }
          ./home.nix
          ./spotify.nix
          ./term.nix
          ./lang.nix
          ./nvim.nix
          ./work.nix
          ./wm/wm.nix
          ./school.nix
          ./firefox.nix
        ];
      };
      nixosConfigurations =
        let
          base_mods = [
            hyprland.nixosModules.default
            home-manager.nixosModules.home-manager
            nur.nixosModules.nur
            ./global/nix-conf.nix
            ./global/configuration.nix
            ./global/containers.nix
            ./global/wm.nix
            ./global/boot.nix
            ./global/users.nix
            ./global/audio.nix
            ./global/console.nix
            ./global/networking.nix
          ];
        in
        {
          legion = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = base_mods ++
              [
                /home/williams/.config/nixpkgs/global/hardware-configuration/legion.nix
                # nixos-hardware.nixosModules.lenovo-legion-16ach6h-hybrid
              ];
          };
          family = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = base_mods ++
              [
                ({ config, lib, pkgs, modulesPath, ... }:
                  {
                    imports =
                      [
                        (modulesPath + "/installer/scan/not-detected.nix")
                      ];

                    zramSwap.memoryPercent = 100;

                    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
                    boot.initrd.kernelModules = [ ];
                    boot.kernelModules = [ "kvm-intel" ];
                    boot.extraModulePackages = [ ];

                    fileSystems."/" =
                      {
                        device = "/dev/disk/by-uuid/14ceaeb8-b960-4b5c-b01b-e0fa269fa0e5";
                        fsType = "ext4";
                      };

                    fileSystems."/boot/efi" =
                      {
                        device = "/dev/disk/by-uuid/2E43-4B37";
                        fsType = "vfat";
                      };

                    swapDevices = [
                      { device = "/dev/sda6"; }
                    ];

                    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
                    # (the default) this is the recommended approach. When using systemd-networkd it's
                    # still possible to use this option, but it's recommended to use it in conjunction
                    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
                    networking.useDHCP = lib.mkDefault true;
                    # networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;
                    # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

                    powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
                    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
                  })
              ];
          };
        };
    };
}
