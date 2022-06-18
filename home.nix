{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    htop
    vscode
    neovim
    discord
    google-chrome
    git
    gh
    clang
    libcxx
    libcxxabi 

    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  # environment.variables.EDITOR = "nvim";
  nixpkgs.overlays = [
    (self: super: {
      neovim = super.neovim.override { vimAlias = true; };
    })
  ];

  fonts.fontconfig.enable = true;

  programs.git = {
    enable = true;
    userName = "William Sørensen";
    userEmail = "47296141+Equilibris@users.noreply.github.com";
  };

  programs.kitty = {
    enable = true;

    font.name = "FiraCode Nerd Font";
    extraConfig = ''
        # background            #c5cdd9
        # foreground            #2b2d37
        # cursor                #4C566A
        # selection_background  #dedede
        # color0                #212121
        # color8                #424242
        # color1                #b7141e
        # color9                #e83a3f
        # color2                #457b23
        # color10               #7aba39
        # color3                #f5971d
        # color11               #fee92e
        # color4                #134eb2
        # color12               #53a4f3
        # color5                #550087
        # color13               #a94dbb
        # color6                #0e707c
        # color14               #26bad1
        # color7                #eeeeee
        # color15               #d8d8d8
        # selection_foreground #222221
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
      source = ./nvim-prelude/plug.vim;
    };
  };
}
