randercmd:
{ pkgs ? import <nixpkgs> {} }:
pkgs.writeTextFile {
  name = "randr-script"; 
  destination = "/bin/monitor-config";
  executable = true;
  text = ''
  #! /usr/bin/env nix-shell
  #! nix-shell -i bash -p wlr-roots

  ${randercmd}

  '';
}
