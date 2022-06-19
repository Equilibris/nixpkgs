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

  programs.alacritty = {
    enable = true;

    settings.font.family = "FiraCode Nerd Font";
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
