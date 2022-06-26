{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    thefuck
    htop
    vscode neovim
    discord
    spotify
    google-chrome
    git gh
    clang libcxx libcxxabi 
    xclip

    nodejs
    rustup

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

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      stty werase '^h'
    '';
  };

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    initExtra = ''
      npm set prefix ~/.npm-global

      export PATH=$PATH:~/.npm-global/bin

      eval "$(~/bin/oh-my-posh init zsh)"
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git" "sudo" "nix-zsh-completions" "rust" "home-manager"
      ];
      theme = "robbyrussell";
    };
  };

  programs.alacritty = {
    enable = true;

    settings = {
      font.family = "FiraCode Nerd Font";

      colors = {
        primary = {
          background = "#2e3440";
          foreground = "#d8dee9";
          dim_foreground = "#a5abb6";
        };
        cursor = {
          text = "#2e3440";
          cursor = "#d8dee9";
        };
        vi_mode_cursor = {
          text = "#2e3440";
          cursor = "#d8dee9";
        };
        selection = {
          background = "#4c566a";
        };
        search = {
          matches = {
            background = "#88c0d0";
          };
          bar = {
            background = "#434c5e";
            foreground = "#d8dee9";
          };
        };
        normal = {
          black = "#3b4252";
          red = "#bf616a";
          green = "#a3be8c";
          yellow = "#ebcb8b";
          blue = "#81a1c1";
          magenta = "#b48ead";
          cyan = "#88c0d0";
          white = "#e5e9f0";
        };
        bright = {
          black = "#4c566a";
          red = "#bf616a";
          green = "#a3be8c";
          yellow = "#ebcb8b";
          blue = "#81a1c1";
          magenta = "#b48ead";
          cyan = "#8fbcbb";
          white = "#eceff4";
        };
        dim = {
          black = "#373e4d";
          red = "#94545d";
          green = "#809575";
          yellow = "#b29e75";
          blue = "#68809a";
          magenta = "#8c738c";
          cyan = "#6d96a5";
          white = "#aeb3bb";
        };
      };
    };
  };

  home.file = {
    "bin/oh-my-posh" = {
      source = pkgs.fetchurl {
        url = "https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64";
        sha256 = "tebha4qAG3/J9LCISIdXa2r1Wr7yYRZsLT5m8Q7QbFc=";
      };
      executable = true;
    };
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
    ".oh-my-zsh/custom/plugins/nix-zsh-completions" = {
      source = pkgs.fetchFromGitHub {
        owner = "spwhitt";
        repo = "nix-zsh-completions";
        rev = "468d8cf752a62b877eba1a196fbbebb4ce4ebb6f";
        sha256 = "TWgo56l+FBXssOYWlAfJ5j4pOHNmontOEolcGdihIJs=";
      };
      recursive = true;
    };
  };
}
