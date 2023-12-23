{ config, pkgs, lib, fetchurl, ... }:

let
  java = false;
  rust = false;
  js = true;
  julia = false;
  lean4 = true;
  eocaml = true;

  docker = false;

  aws = false;
in
{
  nixpkgs.config.allowBroken = true;

  home.packages = with pkgs;
    lib.optionals js [ nodejs ]
    # ++ lib.optionals rust [ rustup /* rust-analyzer */ ]
    ++ lib.optionals lean4 [ elan ]
    ++ lib.optionals eocaml [ opam dune_3 ocamlPackages.ocaml-lsp ocamlPackages.ocamlformat gnumake ocaml ]
    ++ lib.optionals rust [
    ]
    ++ lib.optionals java [ jdt-language-server maven /* jetbrains.jdk openjdk kotlin jetbrains.idea-community */ ]
    ++ lib.optionals julia [ julia-bin patchelf ]

    ++ lib.optionals docker [ pkgs.docker docker-compose ]
    ++ lib.optionals aws [ awscli2 ];

  programs.zsh.initExtra = lib.optionalString eocaml ''
    [[ ! -r /home/williams/.opam/opam-init/init.zsh ]] || source /home/williams/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
  '';
}
