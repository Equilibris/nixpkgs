{ 
  pkgs ? import <nixpkgs> {},
}:
let
  lib             = pkgs.lib;
  fetchFromGitHub = pkgs.fetchFromGitHub;
  rustPlatform    = pkgs.rustPlatform;
in rustPlatform.buildRustPackage rec {
  pname = "rust-battop";
  version = "a434b80774a8f3ef2db934c362914aa7116c450f";

  src = fetchFromGitHub {
    owner = "svartalf";
    repo = pname;
    rev = version;
    hash = "sha256-K7XL4MdLSHfwRBdj/c2HnEtwJMz3Nv/dvGPVaC2iEzc=";
  };

  cargoHash = "sha256-5+uBYmC4nlQxsItw2AXSLM3yw04y5r4VysBCZK91CKE=";
}
