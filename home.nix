{ config, pkgs, ... }:

{
  imports = [ ./term.nix ./lang.nix ];
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    thefuck
    htop
    vscode neovim
    discord betterdiscordctl
    spotify
    google-chrome
    git gh
    clang libcxx libcxxabi 
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
    ".local/share/nvim/site/autoload/plug.vim" = {
      source = "${
        pkgs.fetchFromGitHub {
          owner = "junegunn";
          repo = "vim-plug";
          rev = "8fdabfba0b5a1b0616977a32d9e04b4b98a6016a";
          sha256 = "jAr/xyQAYM9a1Heh1nw1Rsf2dKGRhlXs0Z4ETTAT0hA=";
        }
      }/plug.vim";
    };
    ".config/BetterDiscord/themes/nordic.theme.css" = {
      source = pkgs.fetchurl {
        url = "https://betterdiscord.app/Download?id=33";
        sha256 = "hazRQ45BSkOZ4YnqDw/xTzcXowBgG762vP8zhNrnEZ4=";
      };
    };
  };
}
