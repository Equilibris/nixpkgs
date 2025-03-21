{ config, pkgs, lib, ... }:

let
  theming =
    (import ./theming.nix) { inherit config; inherit pkgs; inherit lib; };

  aliases = {
    cd = "z";
    zm = "zellij attach -c main";

    cls = "clear";
    cfile = "copyq copy <";
    # hms = "export NIXPKGS_ALLOW_UNFREE=1 home-manager switch ";
    hms = "export NIXPKGS_ALLOW_INSECURE=1; export NIXPKGS_ALLOW_UNFREE=1; home-manager switch --impure --flake \"$HOME/.config/nixpkgs/flake.nix\"";
    ":hms" = "hms";
    ":q" = "exit";

    gp = "git push";
    gP = "git pull";
    gs = "git status";
    ga = "git add";

    txd = "tmux new -d --";

    gc = "git commit";

    cfg = "cd ~/.config/nixpkgs";

    "get-local-ip" = "ip route get 1.2.3.4 | awk '{print $3}'";
    "ls-bins" = "compgen -c";

    "find-ports" = "nix-shell -p lsof --run \"sudo lsof -i -P -n | grep LISTEN\"";
    fp = "find-ports";
    l = "eza -al --icons --sort=Extension --git";

    "b-connect-steel" = "bluetoothctl connect 28:9A:4B:0F:64:1E";
    "b-connect-apple" = "bluetoothctl connect AC:1D:06:0E:7E:5F";
  };

  aliasStr = lib.lists.fold (a: c: "${ a}\n${ c}") ""
    (lib.attrsets.mapAttrsToList (k: v: "alias \"${ k}\"=\"${ v}\"") aliases);
in
{
  home.packages = with pkgs; [
    fzf
    thefuck
    jq
    coreutils
    eza
    zoxide
    atuin
    tmux

    (import ./pkgs/pixel-lock.nix { })
  ];
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
      source powerlevel9k.zsh-theme
      source ~/.config/nixpkgs/theme.zsh

      npm set prefix ~/.npm-global

      export PATH=$PATH:~/.npm-global/bin
      export PATH=$PATH:~/.cargo/bin
      export PATH=$PATH:~/bin

      ${aliasStr}

      eval $(thefuck --alias)
      eval "$(zoxide init zsh)"
      eval "$(atuin init zsh)"

      # xhost +SI:localuser:root > /dev/null

      [[ ! -r /home/williams/.opam/opam-init/init.zsh ]] || source /home/williams/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

      screenshot () { grim  -g "$(slurp)" ~/Photos/$(date +'%H:%M:%S.png') }
      killPort   () { fp | grep $1 | echo }

      # if [[ "$(tty)" == "/dev/tty1" ]]; then;   sway; fi
      # if [[ "$(tty)" == "/dev/tty1" ]]; then; hyp;  fi
    '';

    plugins = [
      {
        name = "nix-zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "spwhitt";
          repo = "nix-zsh-completions";
          rev = "468d8cf752a62b877eba1a196fbbebb4ce4ebb6f";
          sha256 = "TWgo56l+FBXssOYWlAfJ5j4pOHNmontOEolcGdihIJs=";
        };
      }
      {
        name = "powerlevel10k";
        src = pkgs.fetchFromGitHub {
          owner = "romkatv";
          repo = "powerlevel10k";
          rev = "8091c8a3a8a845c70046684235a01cd500075def";
          sha256 = "sha256-I0/tktXCbZ3hMYTNvPoWfOEYWRgmHoXsar/jcUB6bpo=";
        };
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          repo = "zsh-autosuggestions";
          owner = "zsh-users";
          rev = "a411ef3e0992d4839f0732ebeb9823024afaaaa8";
          sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        };
      }
      {
        name = "nx-completion";
        src = pkgs.fetchFromGitHub {
          owner = "jscutlery";
          repo = "nx-completion";
          rev = "84386914d55b2e73285069c8f156348255da4a60";
          sha256 = "sha256-deYpsbnWDBk/uRzJetuHg+LSt6O9U1fOMBEv1GHBrPo=";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "122dc464392302114556b53ec01a1390c54f739f";
          sha256 = "sha256-ffD0iHf9WVuE6QzZCkuDgIWj+BY/BRxtYNMi8osJohI=";
        };
      }
    ];

    oh-my-zsh = {
      enable = true;

      plugins = [ "git" "sudo" "rust" "zsh-navigation-tools" ];

      theme = "robbyrussell";
    };
  };

  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font";

    extraConfig = ''
      ${theming.kitty}
      # linux_display_server x11
    '';
  };

  programs.zellij = {
    enable = false;

    settings = {
      copy_command = "wl-copy";
      ui.pane_frames.rounded_corners = true;
      theme = "catppuccin-mocha";

      pane_viewport_serialization = true;
      session_serialization = true;
      scrollback_lines_to_serialize = 1000;
    };
  };

  home.file =
    lib.lists.fold
      (curr: acc: acc // {
        "bin/${curr.name}" = {
          source = curr.src;
          executable = true;
        };
      })
      { } [
      { name = "get-battery"; src = ./scripts/get-battery; }
      { name = "toggle_kbd"; src = ./scripts/toggle_kbd; }
      { name = "restart-blue"; src = ./scripts/restart-blue.sh; }
      { name = "recursive-gs"; src = ./scripts/recursive-gs.sh; }
      { name = "hyp"; src = ./scripts/hyprland.sh; }
      # { name = "pixel-lock";  src = ./scripts/pixel-lock; }
    ];
}

