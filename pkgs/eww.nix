{ pkgs ? import <nixpkgs> }:

let 
  src = pkgs.fetchFromGitHub {
        owner = "elkowar";
        repo = pname;
        rev = "v0.3.0";
        sha256 = "sha256-Kkyn/5Fjo3gBjkGSy+AFhOl5pZrb2ChzrqajOZagsRQ=";
      };

in
  pkgs.stdenv.mkDerivation {
  };

