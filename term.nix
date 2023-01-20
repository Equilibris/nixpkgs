{ config, pkgs, lib, ... }:

let
  aliases = {
    cls = "clear";
    cfile = "copyq copy <";
    hms = "home-manager switch";
    ":hms" = "hms";
    ":q" = "exit";

    gp = "git push";
    gP = "git pull";
    gs = "git status";
    ga = "git add";

    gc = "git commit";

    cfg = "cd ~/.config/nixpkgs";

    "get-local-ip" = "ip route get 1.2.3.4 | awk '{print $3}'";
    "ls-bins" = "compgen -c";

    "find-ports" = "nix-shell -p lsof --run \"sudo lsof -i -P -n | grep LISTEN\"";
    fp = "find-ports";
    l = "exa -al --icons --sort=Extension";

    "b-connect-steel" = "bluetoothctl connect 28:9A:4B:0F:64:1E";
    "b-connect-apple" = "bluetoothctl connect AC:1D:06:0E:7E:5F";
  };

  aliasStr = lib.lists.fold (a: c: "${a}\n${c}") ""
    (lib.attrsets.mapAttrsToList (k: v: "alias \"${k}\"=\"${v}\"") aliases);
  unstable = import <nixos-unstable> { };
in
{
  home.packages = with unstable; [
    fzf
    thefuck
    (unstable.nerdfonts.override { fonts = [ "FiraCode" ]; })
    jq
    coreutils
    exa
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

      # xhost +SI:localuser:root > /dev/null

      screenshot () { grim  -g "$(slurp)" ~/Photos/$(date +'%H:%M:%S.png') }
      killPort   () { fp | grep $1 | echo }

      if [[ "$(tty)" == "/dev/tty1" ]]; then; sway --unsupported-gpu; fi
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

    extraConfig = builtins.readFile "${pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/connorholyday/nord-kitty/master/nord.conf";
        sha256 = "4R5wNmrP2JkIW9t603AmJEcHJUQ/RYw7NwuvmrJhdrk=";
    }}";
  };

  home.file = {
    ".config/nix/nix.conf" = { source = ./nix.conf; };
  } //
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
    # { name = "pixel-lock";  src = ./scripts/pixel-lock; }
  ];
}

