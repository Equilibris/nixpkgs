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
          { nixpkgs.config.allowUnfree = true; }
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
        };
    };
}
