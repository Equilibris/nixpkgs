{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [ htop vscode neovim discord google-chrome git gh ];

  # environment.variables.EDITOR = "nvim";
  nixpkgs.overlays = [
    (self: super: {
      neovim = super.neovim.override { vimAlias = true; };
    })
  ];

  home.file = {
    ".config/nvim" = {
      source = ./nvim;
      recursive = true;
    };
    ".local/share/nvim/site/autoload/plug.vim" = {
      source = ./nvim-prelude/plug.vim;
    };
  };
}
