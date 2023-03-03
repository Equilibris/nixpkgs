{
  inputs = {
    unstable.url = "github:NixOS/nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, hyprland, home-manager, unstable, nur }: {
    homeConfigurations."williams@nixos" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      modules = [ ./home.nix ];
    };
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [
          hyprland.nixosModules.default
          home-manager.nixosModules.home-manager
          nur.nixosModules.nur
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.williams = import /home/williams/.config/nixpkgs/home.nix;
          }
          ./nix-conf.nix
          ./configuration.nix
          ./hardware-configuration.nix
          ./wm.nix
          ./boot.nix
          ./users.nix
          ./audio.nix
          ./console.nix
          ./networking.nix
        ];
    };
  };
}
