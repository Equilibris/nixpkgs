{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    thefuck
    htop
    vscode neovim
    discord
    google-chrome
    git gh
    clang libcxx libcxxabi 

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

    theme.name = "Orchis";
    theme.package = pkgs.orchis-theme;
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
    # plugins = [
    #   {
    #     name = "zsh-nix-shell";
    #     file = "nix-shell.plugin.zsh";
    #     src = pkgs.fetchFromGitHub {
    #       owner = "chisui";
    #       repo = "zsh-nix-shell";
    #       rev = "v0.5.0";
    #       sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
    #     };
    #   }
    # ];
    initExtra = ''
      npm set prefix ~/.npm-global

      export PATH=$PATH:~/.npm-global/bin

      eval "$(~/.config/nixpkgs/tmp/oh-my-posh init zsh)"
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
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
    ".config/nvim" = {
      source = ./nvim;
      recursive = true;
    };
    ".local/share/nvim/site/autoload/plug.vim" = {
      source = ./tmp/plug.vim;
    };
  };
}
