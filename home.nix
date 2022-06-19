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

  home.sessionPath = [ "$HOME/.npm-global/bin" ];

  # environment.variables.EDITOR = "nvim";
  nixpkgs.overlays = [
    (self: super: {
      neovim = super.neovim.override { vimAlias = true; };
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

      eval "$(~/.config/nixpkgs/tmp/oh-my-posh init zsh)"
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };

  programs.kitty = {
    enable = true;

    font.name = "FiraCode Nerd Font";
    extraConfig = ''
      foreground            #D8DEE9
      background            #2E3440
      selection_foreground  #000000
      selection_background  #FFFACD
      url_color             #0087BD
      cursor                #81A1C1
      
      # black
      color0   #3B4252
      color8   #4C566A
      
      # red
      color1   #BF616A
      color9   #BF616A
      
      # green
      color2   #A3BE8C
      color10  #A3BE8C
      
      # yellow
      color3   #EBCB8B
      color11  #EBCB8B
      
      # blue
      color4  #81A1C1
      color12 #81A1C1
      
      # magenta
      color5   #B48EAD
      color13  #B48EAD
      
      # cyan
      color6   #88C0D0
      color14  #8FBCBB
      
      # white
      color7   #E5E9F0
      color15  #ECEFF4
      '';

    settings = { 
      enable_audio_bell = false;
      window_border_width = "0.0pt";
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
