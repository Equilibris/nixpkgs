{ config, pkgs, lib, ... }:
let
  # pkgs = import <nixos-pkgs> {
  #   overlays = [
  #     (self: super: {
  #       neovim = super.neovim.override { vimAlias = true; viAlias = true; };
  #     })
  #   ];
  # };

  theming =
    (import ./theming.nix) { inherit config; inherit pkgs; inherit lib; };
in
{
  home.packages = with pkgs; [
    statix
    stylua
    ripgrep
    proselint
    wget

    nil
    rnix-lsp
  ];

  # environment.variables.EDITOR = "nvim";
  programs.zsh.initExtra = "export nvim_theme=${theming.nvim-name};";
  home.file = {
    ".config/nvim" = {
      source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixpkgs/nvim";
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

