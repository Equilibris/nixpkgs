{ config, pkgs, lib, ... }:

{
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

      eval $(thefuck --alias)
      eval "$(~/bin/oh-my-posh init zsh)"

      alias findPorts="nix-shell -p lsof --run \"sudo lsof -i -P -n | grep LISTEN\""
      alias fp=findPorts

      killPort() {
        fp | grep $1 | echo
      }
      '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git" "sudo" "rust"
      ];
      theme = "robbyrussell";
    };
  };

  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font";

    extraConfig = builtins.readFile "${pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/connorholyday/nord-kitty/master/nord.conf";
        sha256 = "4R5wNmrP2JkIW9t603AmJEcHJUQ/RYw7NwuvmrJhdrk=";
    }}";
  };

  programs.alacritty = {
    enable = false;

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

