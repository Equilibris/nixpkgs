# 

{ pkgs ? import <nixpkgs> {} }:
let
  stdenv = pkgs.stdenv;
in
  stdenv.mkDerivation {
    name = "circuitjs1";

    src = builtins.fetchTarball {
      url = "https://www.falstad.com/circuit/offline/circuitjs1-linux64.tgz";
    };

    unpackPhase = "true";

    installPhase = ''
      mkdir -p $out
      mkdir -p $out/bin
      # cp 
      echo $src
    '';
  }
