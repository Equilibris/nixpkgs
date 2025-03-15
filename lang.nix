{ config, pkgs, lib, fetchurl, fenix, ... }:

let
  java   = false;
  rust   = false;
  js     = true;
  cxx    = false;
  julia  = false;
  lean4  = true;
  eocaml = true;
  prolog = true;

  latex = false;

  docker = false;
  aws = false;
in
{
  nixpkgs.config.allowBroken = true;

  home.packages = with pkgs;
    lib.optionals js [ nodejs ]
    ++ lib.optionals rust [
      # rustup /* rust-analyzer */
      # (fenix-pkgs.withComponents [
      #   "cargo"
      #   "clippy"
      #   "rust-src"
      #   "rustc"
      #   "rustfmt"
      #   "miri"
      #   "rust-analyzer"
      # ])
      cargo-insta
      sqlx-cli
      bacon
    ]
    ++ lib.optionals lean4 [ elan ]
    ++ lib.optionals prolog [ swiProlog ]
    ++ lib.optionals eocaml [ opam dune_3 ocamlPackages.ocaml-lsp ocamlPackages.ocamlformat gnumake ocaml ]
    ++ lib.optionals cxx [
      clang-tools stdenv.cc.cc.lib clang libcxx libcxxabi clang.bintools clang.bintools
    ]
    ++ lib.optionals latex [
      texlive.combined.scheme-medium pandoc
      hunspell
      hunspellDicts.nb-no hunspellDicts.en-gb-ize
    ]
    ++ lib.optionals java [ 
      jdk17
      # jdt-language-server maven /* jetbrains.jdk openjdk kotlin */ jetbrains.idea-community
    ]
    ++ lib.optionals julia [ julia-bin patchelf ]

    ++ lib.optionals docker [ pkgs.docker docker-compose ]
    ++ lib.optionals aws [ awscli2 ];

  programs.zsh.initExtra = lib.optionalString eocaml ''
    [[ ! -r /home/williams/.opam/opam-init/init.zsh ]] || source /home/williams/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
  '';
}
