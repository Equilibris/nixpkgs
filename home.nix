{ config, pkgs, lib, ... }:


let
  #   spicetify = fetchTarball https://github.com/pietdevries94/spicetify-nix/archive/master.tar.gz;
  unstable = import <nixos-unstable> { config.allowUnfree = true; };
in
{
  imports = [
    ./spotify.nix
    ./term.nix
    ./lang.nix
    ./nvim.nix
    ./wm/wm.nix
    ./work.nix
    ./school.nix
  ];
  nixpkgs.config.allowUnfree = true;
  home.packages = with unstable; [
    libsForQt5.qtstyleplugins

    thefuck
    unzip
    bat
    htop
    discord
    google-chrome
    git
    gh
    git-secret

    gcc
    # stdenv.cc.cc.lib clang libcxx libcxxabi clang.bintools clang.bintools

    obsidian

    # (import ./pkgs/battop.nix {})
    # (import ./pkgs/spotify.nix {})

    # (pkgs.callPackage (import "${spicetify}/package.nix") {
    #   inherit pkgs;
    #   theme = "Dribbblish";
    #   colorScheme = "horizon";
    #   enabledCustomApps = ["reddit"];
    #   enabledExtensions = ["newRelease.js" "autoVolume.js"];
    #   thirdParyExtensions = {};
    # })

    (unstable.nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  # home.sessionPath = [ "$HOME/.npm-global/bin" ];


  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;

    theme.name = "Nordic";
    theme.package = unstable.nordic;

    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  programs.gpg = {
    enable = true;
  };
  programs.git = {
    enable = false;
    userName = "William Sørensen";
    userEmail = "47296141+Equilibris@users.noreply.github.com";
    extraConfig = {
      init.defaultBranchName = "main";
      safe.directory = "*";
    };
  };

  home.file = lib.lists.fold
    (curr: acc: acc // {
      ".config/BetterDiscord/${curr.name}" = {
        source = pkgs.fetchurl {
          url = "http://betterdiscord.app/Download?id=${toString curr.id}";
          sha256 = if builtins.hasAttr "sha256" curr then curr.sha256 else "";
        };
      };
    })
    { } [
    #     {
    #       name = "themes/nordic.theme.css"; id = 33; 
    #       sha256 = "hazRQ45BSkOZ4YnqDw/xTzcXowBgG762vP8zhNrnEZ4=";
    #     }
    #     {
    #       name = "themes/ClearVision.theme.css"; id = 23;
    #       sha256 = "3YgErNGy1Q7tTPrQ1R9U/2b9GY2DdhxjbAF/P2aZXyA=";
    #     }
    #     {
    #       name = "plugins/ShowHiddenChannels.plugin.js"; id = 103;
    #       sha256 = "DZmbmc7JFR38o9dHeZLhJkQc/jjkNbUxCj6n6ibXxgs=";
    #     }
  ];
}
