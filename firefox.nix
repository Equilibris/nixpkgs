{ config, pkgs, lib, nur, ... }:

let
  unstable = import <nixos-unstable> {
    config.allowUnfree = true;

    config.packageOverrides = pkgs: {
      nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
    };
  };
  profile-path = ".mozilla/firefox/williams/";
  chrome-path = ".mozilla/firefox/williams/chrome";
in
{
  home.file.${chrome-path} = {
      source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixpkgs/fire/cascade/chrome";
      recursive = true;
  };

  programs.firefox = {
    enable = true;

    # package = pkgs.firefox-wayland;
    # preferences = {
    #   "widget.use-xdg-desktop-portal.file-picker" = 1;
    # };

    profiles."williams" = {
      id = 0;
      name = "William Sørensen";

      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };

      # extensions =
      #   with nur.repos.rycee.firefox-addons; [
      #     bitwarden
      #     darkreader
      #     vimium
      #     ublock-origin
      #   ];

    };
  };
}
