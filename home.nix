{ config, pkgs, lib, ... }:

{
  imports = [ ./term.nix ./lang.nix ./work.nix ];
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    thefuck
    htop
    vscode neovim
    discord betterdiscordctl
    spotify
    google-chrome
    git gh git-secret
    clang libcxx libcxxabi clang.bintools clang.bintools
    xclip

    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  # home.sessionPath = [ "$HOME/.npm-global/bin" ];

  # environment.variables.EDITOR = "nvim";
  nixpkgs.overlays = [
    (self: super: {
      neovim = super.neovim.override { vimAlias = true; viAlias = true; };
    })
  ];

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;

    theme.name = "Nordic";
    theme.package = pkgs.nordic;

    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  programs.gpg = {
    enable = true;
  };
  programs.git = {
    enable = true;
    userName = "William Sørensen";
    userEmail = "47296141+Equilibris@users.noreply.github.com";
  };

  home.file = {
    ".config/nvim" = {
      source = ./nvim;
      recursive = true;
    };
    ".local/share/nvim/site/pack/packer/start/packer.nvim" = {
      source = 
        pkgs.fetchFromGitHub {
          owner = "wbthomason";
          repo = "packer.nvim";
          rev = "d268d2e083ca0abd95a57dfbcc5d5637a615e219";
          sha256 = "sha256-zgfJEVXWPA93SAbZUA1nivPrJAGznfOfPX5uI0Ipwas=";
        };
      recursive = true;
    };
  } // lib.lists.fold (curr: acc: acc // {
    ".config/BetterDiscord/${curr.name}" = {
      source = pkgs.fetchurl {
        url = "http://betterdiscord.app/Download?id=${toString curr.id}";
        sha256 = if builtins.hasAttr "sha256" curr then curr.sha256 else "";
      };
    };
  }) {} [ 
    {
      name = "themes/nordic.theme.css"; id = 33; 
      sha256 = "hazRQ45BSkOZ4YnqDw/xTzcXowBgG762vP8zhNrnEZ4=";
    }
    {
      name = "themes/ClearVision.theme.css"; id = 23;
      sha256 = "3YgErNGy1Q7tTPrQ1R9U/2b9GY2DdhxjbAF/P2aZXyA=";
    }
    {
      name = "plugins/ShowHiddenChannels.plugin.js"; id = 103;
      sha256 = "DZmbmc7JFR38o9dHeZLhJkQc/jjkNbUxCj6n6ibXxgs=";
    }
  ];
}
