{ config, pkgs, lib, ... }:
let
  unstable = import <nixos-unstable> {
    overlays = [
      (self: super: {
        neovim = super.neovim.override { vimAlias = true; viAlias = true; };
      })
    ];
  };
in
{
  home.packages = with unstable; [
    neovim
    rust-analyzer statix stylua 
    ripgrep proselint wget
  ];

  # environment.variables.EDITOR = "nvim";
  home.file = {
    ".config/nvim" = {
      source = ./nvim;
      recursive = true;
    };
    # ".local/share/nvim/site/pack/packer/start/packer.nvim" = {
    #   source = 
    #     pkgs.fetchFromGitHub {
    #       owner = "wbthomason";
    #       repo = "packer.nvim";
    #       rev = "d268d2e083ca0abd95a57dfbcc5d5637a615e219";
    #       sha256 = "sha256-zgfJEVXWPA93SAbZUA1nivPrJAGznfOfPX5uI0Ipwas=";
    #     };
    #   recursive = true;
    # };
  };
}

