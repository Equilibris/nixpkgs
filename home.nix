{ config, pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugins
    qt5.qtwayland
    xdg-utils
    xorg.xprop

    thefuck
    unzip
    bat
    htop
    discord
    git
    gh
    git-secret
    libreoffice

    glib

    # teams

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

    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    # XDG_CURRENT_DESKTOP = "sway";
  };

  # home.sessionPath = [ "$HOME/.npm-global/bin" ];

  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 59.9;
    longitude = 10.7;
  };

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;

    theme.name = "Nordic";
    theme.package = pkgs.nordic;

    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
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
