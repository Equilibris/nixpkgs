{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nur.url = "github:nix-community/NUR";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devenv.url = "github:cachix/devenv";
    typst.url = "github:typst/typst";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
    allow-unfree = true;
    permittedInsecurePackages = [
      "electron-25.9.0"
    ];
  };

  outputs =
    { self
    , nixpkgs
    , hyprland
    , home-manager
    , nur
    , nixos-hardware
    , typst
    , fenix
    , devenv
    }:
    let
      system = "x86_64-linux";
      fenix-pkgs = fenix.packages.${system}.latest;
      pkgs = nixpkgs.legacyPackages.${system} // { inherit (fenix-pkgs) rust-src; };
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
            home.packages = [ typst.packages.${system}.default devenv.packages.${system}.default ];
          }
          {
            home.packages = with pkgs; [
              # (eww.packages.${system}.eww-wayland)
              (fenix-pkgs.withComponents [
                "cargo"
                "clippy"
                "rust-src"
                "rustc"
                "rustfmt"
                "miri"
                "rust-analyzer"
              ])
              cargo-insta
              sqlx-cli
              bacon
            ];
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
            ./cachix.nix
            ./global/configuration.nix
            ./global/containers.nix
            ./global/boot.nix
            ./global/users.nix
            ./global/audio.nix
            ./global/console.nix
            ./global/networking.nix
          ];
        in
        {
          server = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = base_mods ++
              [
                /home/williams/.config/nixpkgs/global/hardware-configuration/hardware-configuration.main-desktop.nix

                ((import ./global/wm.nix) {
                  enable-sway = true;
                  enable-wayland = true;
                })

                {
                  environment.systemPackages = [
                    (import ./global/create-randr.nix [
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
                    ]
                      { })
                  ];
                }

                ({ config, lib, pkgs, modulesPath, ... }: {
                  services.openssh = {
                    enable = true;
                    settings.PasswordAuthentication = false;
                    settings.KbdInteractiveAuthentication = false;
                  };
                  services.getty.autologinUser = "williams";
                  users.users."williams".openssh.authorizedKeys.keys = [
                    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCs/0iZDUAQ66/lmYFhdnBQZkq4i4Yh/FtJU0qRfr9FBZHwml5fe3yKnASrC3Ch3uMBALtFeR7i0HFEfjYNBfPyMXUmBUXkkwUbXa94U9kAy82LMrnwCwD65/wzc/ZhlcSWLijKp1J+/l7oSPGyHqgbJkedfvL7bGmZUP1r3g4BUwOolVvfqCb71H66uDCa2KYd3i27kGy9Z+edcahtbySodmOzvAcxGs6u1ncTSNpUs2ZTlypPCtInPCYJM3ww9IxldRiMlwVJ+qRdaQUPrwWHghwj3hOpsx0tMGa3x5kkTfEeiIbdu7m+WpU8Q9dG3LeJwnIgA7rs51eyGojtJMJkclddd42Lmd2wh29ztEBgV3janQx6eRbLdBG+3AbhnbpebnnyVEhbxwD/FjoPC01/xty5gXfi9LZDlqVOlR4fNSgVAKiTb8YItym3o+V1UQBxvSHxuiRGJqA7DGs3dQuMmSTvi4VxpcQ079ywuC/lx6NdyMezn6/bcAC3PkD4YYE= williams@nixos"
                  ];
                  services.tailscale.enable = false;
                  systemd.services.auto-ts-up = {
                    enable = false;
                    description = "auto setup tawilsacale";
                    serviceConfig = {
                      Type = "forking";
                      ExecStart = pkgs.writeShellScript "auto ts"
                        ''
                          /run/current-system/sw/bin/tailscale up
                          /run/current-system/sw/bin/tailscale up --ssh
                        '';
                    };
                    wantedBy = [ "default.target" ];
                  };
                })
              ];
          };
          legion = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = base_mods ++
              [
                /home/williams/.config/nixpkgs/global/hardware-configuration/legion.nix
                /home/williams/.config/nixpkgs/global/wifi.nix
                /home/williams/.config/nixpkgs/global/eduroam.nix
                # nixos-hardware.nixosModules.lenovo-legion-16ach6h-hybrid
                ((import ./global/wm.nix) {
                  enable-sway = true;
                  enable-wayland = true;
                  enable-hyprland = true;
                })
              ];
          };
          family = nixpkgs.lib.nixosSystem
            {
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
