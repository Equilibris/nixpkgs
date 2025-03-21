{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    eww = {
      url = "github:elkowar/eww";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # spicetify-nix = {
    #   url = "github:the-argus/spicetify-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    devenv.url = "github:cachix/devenv";
    typst.url = "github:typst/typst";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
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
    , eww
    , home-manager
    # , nur
    , nixos-hardware
    , typst
    , fenix
    , devenv
    # , spicetify-nix
    }:
    let
      system = "x86_64-linux";
      fenix-pkgs = fenix.packages.${system}.latest;
      pkgs = nixpkgs.legacyPackages.${system} // { inherit (fenix-pkgs) rust-src; };
    in
    {
      homeConfigurations.williams = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # extraSpecialArgs = { inherit spicetify-nix; };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          # nur.hmModules
          {
            home.stateVersion = "22.11";
            home.username = "williams";
            home.homeDirectory = "/home/williams";
            home.packages = [ typst.packages.${system}.default devenv.packages.${system}.default ];
          }
          {
            # home.packages = with pkgs; [
            # ];
          }
          ./gnome.nix
          # ./spotify-spice.nix
          ./home.nix
          ./term.nix
          ./lang.nix
          ./nvim.nix
          ./work.nix
          ./wm/wm.nix
          ./school.nix
          ./firefox.nix
          ./obsidian.nix
        ];
      };
      nixosConfigurations =
        let
          base_mods = [
            hyprland.nixosModules.default
            home-manager.nixosModules.home-manager
            # nur.nixosModules.nur
            ./global/nix-conf.nix
            ./cachix.nix
            ./global/configuration.nix
            ./global/containers.nix
            ./global/boot.nix
            ./global/users.nix
            ./global/console.nix
            ./global/networking.nix
            ./global/syncthing.nix
          ];
          autologin = { services.getty.autologinUser = "williams"; };
        in
        {
          server = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = base_mods ++
              [
                ./global/hardware-configuration/hardware-configuration.main-desktop.nix
                ./global/audio.nix

                ((import ./global/wm.nix) {
                  enable-hyprland = true;
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

                autologin

                ({ config, lib, pkgs, modulesPath, ... }: {
                  services.openssh = {
                    enable = true;
                    settings.PasswordAuthentication = false;
                    settings.KbdInteractiveAuthentication = false;
                  };
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
          surface = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = base_mods ++
              [
                /home/williams/.config/nixpkgs/global/hardware-configuration/surface.nix

                autologin
                nixos-hardware.nixosModules.microsoft-surface-pro-intel

                /home/williams/.config/nixpkgs/global/audio.nix
                # /home/williams/.config/nixpkgs/global/eduroam.nix
                # nixos-hardware.nixosModules.lenovo-legion-16ach6h-hybrid
                {
                  environment.variables = {
                    WS_GDK_SCALE = "2";
                    # GDK_SCALE = "2";
                  };

                  nix.buildMachines = [{
                    hostName = "2.tcp.eu.ngrok.io:13177";
                    system = "x86_64-linux";
                    protocol = "ssh-ng";
                    # if the builder supports building for multiple architectures, 
                    # replace the previous line by, e.g.
                    # systems = ["x86_64-linux" "aarch64-linux"];
                    maxJobs = 1;
                    speedFactor = 2;
                    supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
                    mandatoryFeatures = [ ];
                  }];
                  nix.distributedBuilds = true;
                }


                ((import ./global/wm.nix) {
                  enable-hyprland = false;
                  enable-wayland = true;
                  enable-gnome = true;
                })
              ];
          };
          legion = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = base_mods ++
              [
                ./global/hardware-configuration/legion.nix
                # ./global/wifi.nix
                # ./global/eduroam.nix
                ./global/audio.nix
                # nixos-hardware.nixosModules.lenovo-legion-16ach6h-hybrid
                ((import ./global/wm.nix) {
                  enable-hyprland = false;
                  enable-wayland = true;
                  enable-gnome = true;
                })

                ({ config, lib, pkgs, modulesPath, ... }: {
                  environment.systemPackages = [ pkgs.ngrok ];

                  services.openssh = {
                    enable = true;
                    settings.PasswordAuthentication = false;
                    settings.KbdInteractiveAuthentication = false;
                  };
                  users.users."williams".openssh.authorizedKeys.keys = [
                    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFb/I7aNw8aZJI43YYlkKDCUdtoKty5xDRMiNhjEoz+p williams@nixos"
                  ];
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
