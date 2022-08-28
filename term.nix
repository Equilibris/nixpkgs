{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    fzf
    thefuck
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
    jq
    coreutils
  ];
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      stty werase '^h'
    '';
  };

  programs.fish = {
    enable = true;

    shellAbbrs = {
      cls = "clear";
      cfile = "copyq copy <";
      hms = "home-manager switch";
      ":hms" = "hms";
      ":q" = "exit";

      gp = "git push";
      gP = "git pull";
      gs = "git status";

      cfg = "cd ~/.config/nixpkgs";

      "get-local-ip" = "ip route get 1.2.3.4 | awk '{print $3}'";
      "ls-bins" = "compgen -c";

      "find-ports" = "nix-shell -p lsof --run \"sudo lsof -i -P -n | grep LISTEN\"";
      fp = "find-ports";
    };

    shellInit = ''
      # for p in /run/current-system/sw/bin
      #   if not contains $p $fish_user_paths
      #     set -g fish_user_paths $p $fish_user_paths
      #   end
      # end
      source ~/bin/fisher

      fish_add_path --move --prepend --path $HOME/.nix-profile/bin /run/wrappers/bin /etc/profiles/per-user/$USER/bin /nix/var/nix/profiles/default/bin /run/current-system/sw/bin
      # source ~/.oh-my-zsh/custom/plugins/nx-completion/nx-completion.plugin.zsh
      # npm set prefix ~/.npm-global

      # export PATH=$PATH:~/.npm-global/bin
      # export PATH=$PATH:~/bin

      # eval $(thefuck --alias)
      # eval "$(~/bin/oh-my-posh init zsh --config ~/.config/nixpkgs/posh.config.json)"

      # xhost +SI:localuser:root > /dev/null

      function screenshot 
        grim  -g "$(slurp)" /tmp/$(date +'%H:%M:%S.png')
      end
      function killPort
        fp | grep $1 | echo
      end
      '';

      plugins = [
        # {
        #   name = "Tide";
        #   src = pkgs.fetchFromGitHub {
        #     owner = "IlanCosman";
        #     repo = "tide";
        #     rev = "13fa55ef109009e04e6e5fabda0d0e662b4e6315";
        #     sha256 = "sha256-+6LdcFLqDzUcCmBoKO4LDH5+5odqVqUb1NmEVNMEMjs=";
        #   };
        # }
      ];
  };

  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font";

    extraConfig = builtins.readFile "${pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/connorholyday/nord-kitty/master/nord.conf";
        sha256 = "4R5wNmrP2JkIW9t603AmJEcHJUQ/RYw7NwuvmrJhdrk=";
    }}";
  };

  home.file = {
    ".config/nix/nix.conf" = { source = ./nix.conf; };
    "bin/fisher" = {
      source = pkgs.fetchurl {
        url = "https://git.io/fisher";
        sha256 = "sha256-j6rgDiyFG4StG9WV2szKVeTAfW3oei1p27PqtIt9ONk=";
      };
      executable = true;
    };
    ".config/fish/fish_plugins" = {
      text = ''
        jorgebucaran/fisher
        ilancosman/tide
      '';
    };
    "bin/oh-my-posh" = {
      source = pkgs.fetchurl {
        url = "https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v8.17.0/posh-linux-amd64";
        sha256 = "sha256-8krnWajeEclA677yk+8b72vlIsxWDdPF6cI361RrFoo=";
      };
      executable = true;
    };
  } //
    lib.lists.fold 
      (curr: acc: acc // {
        "bin/${curr.name}" = {
          source = curr.src;
          executable = true;
        };
      }) {} [
        { name = "get-battery"; src = ./scripts/get-battery; }
        { name = "toggle_kbd";  src = ./scripts/toggle_kbd; }
        { name = "pixel-lock";  src = ./scripts/pixel-lock; }
      ];
}

