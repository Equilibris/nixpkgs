# Downloads sourced from https://marketplace.atlassian.com/apps/1210992/atlassian-plugin-sdk-deb/version-history

{ pkgs ? import <nixpkgs> { } }:
let
  stdenv = pkgs.stdenv;
in
stdenv.mkDerivation {
  name = "atlas-sdk";

  src = pkgs.fetchurl {
    url = "https://marketplace.atlassian.com/download/apps/1210992/version/42510";
    sha256 = "sha256-DJPVoZUTsAQDDIu0pDLXS/IR/4ILxoNQ68N+aGUGLo8=";
  };

  nativeBuildInputs = [
    pkgs.autoPatchelfHook # Automatically setup the loader, and do the magic
    pkgs.dpkg
  ];

  buildInputs = [
    pkgs.maven
  ];

  unpackPhase = "true";

  installPhase = ''
    mkdir -p $out
    mkdir -p $out/bin
    dpkg -x $src $out
    cp -av $out/usr/share/atlassian-plugin-sdk-8.2.7/bin/* $out/bin
  '';
}
