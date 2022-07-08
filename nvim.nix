{ config, pkgs, lib, ... }:
let
  # https://github.com/NixOS/nixpkgs/blob/nixos-22.05/pkgs/development/tools/sumneko-lua-language-server/default.nix
  luaLsp = pkgs.stdenv.mkDerivation {
    name = "lua-lsp";
    src = pkgs.fetchFromGitHub {
      owner = "sumneko";
      repo = "lua-language-server";
      rev = "f407cb07ed559daf7a5a943d8896e849791ae5b7";
      sha256 = "sha256-n54PWkiB+vXAqIOZ5FOTUNgGhAdBs81Q1WYxJ2XIb8o=";
      fetchSubmodules = true;
    };

    nativeBuildInputs = [
      pkgs.ninja
      pkgs.makeWrapper
    ];


    preBuild = ''
      cd 3rd/luamake
    '';

    postBuild = ''
      cd ../..
      ./3rd/luamake/luamake rebuild
    '';

    ninjaFlags = [
      "-fcompile/ninja/${lib.toLower "Linux"}.ninja"
    ];

    installPhase = ''
      runHook preInstall
      install -Dt "$out"/share/lua-language-server/bin bin/lua-language-server
      install -m644 -t "$out"/share/lua-language-server/bin bin/*.*
      install -m644 -t "$out"/share/lua-language-server {debugger,main}.lua
      cp -r locale meta script "$out"/share/lua-language-server
      # necessary for --version to work:
      install -m644 -t "$out"/share/lua-language-server changelog.md
      makeWrapper "$out"/share/lua-language-server/bin/lua-language-server \
        $out/bin/lua-language-server \
        --add-flags "-E $out/share/lua-language-server/main.lua \
        --logpath='~/.cache/sumneko_lua/log' \
        --metapath='~/.cache/sumneko_lua/meta'"
      runHook postInstall
    '';
  };
in {
  home.packages = [ pkgs.neovim luaLsp pkgs.rust-analyzer ];

  # environment.variables.EDITOR = "nvim";
  nixpkgs.overlays = [
    (self: super: {
      neovim = super.neovim.override { vimAlias = true; viAlias = true; };
    })
  ];

  home.file = {
    ".config/nvim" = {
      source = ./nvim;
      recursive = true;
    };
    ".local/share/nvim/site/pack/packer/start/packer.nvim" = {
      source = 
        pkgs.fetchFromGitHub {
          owner = "wbthomason";
          repo = "packer.nvim";
          rev = "d268d2e083ca0abd95a57dfbcc5d5637a615e219";
          sha256 = "sha256-zgfJEVXWPA93SAbZUA1nivPrJAGznfOfPX5uI0Ipwas=";
        };
      recursive = true;
    };
  };
}

