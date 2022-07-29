randercmd:
{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation {
  name = "randr-script"; 
  buildInputs = [ pkgs.wlr-randr ];

  src = pkgs.writeScript "prime-randr" randercmd;

  unpackPhase = "true";

  installPhase = "mkdir -p $out/bin; cp $src $out/bin/prime-randr";
}
