{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    unstable.url = "github:NixOS/nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, hyprland, home-manager, unstable }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [
          hyprland.nixosModules.default
          (import ./nix-conf.nix)
          (import ./configuration.nix)
          (import ./hardware-configuration.nix)
          (import ./wm.nix)
          (import ./boot.nix)
          (import ./users.nix)
          (import ./audio.nix)
          (import ./console.nix)
          (import ./networking.nix)
        ];
    };
  };
}
