config:
{ pkgs ? import <nixpkgs> {} }:
let 
  textContent = pkgs.lib.lists.fold (
    curr: acc: "${acc} --output ${curr.output} --pos ${
      builtins.toString curr.x
    },${
      builtins.toString curr.y
    }"
    ) "" config;

  myScript = pkgs.writeTextFile {
    name = "conf-randr";
    executable = true;
    destination = "/bin/conf-randr.sh";
    text = ''
      #! /usr/bin/env nix-shell
      #! nix-shell -i bash -p wlr-randr xorg.xhost

      xhost +SI:localuser:root > /dev/null
      wlr-randr ${textContent}
    '';
  };
in pkgs.stdenv.mkDerivation rec {
  pname = "conf-randr";
  version = "0.0.1";

  # Copy the script defined in the `let` statement above into the final
  # derivation.
  #
  buildInputs = [ myScript ];
  nativeBuildInputs = [ pkgs.wlr-randr ];
  builder = pkgs.writeTextFile {
    name = "builder.sh";
    text = ''
      . $stdenv/setup
      mkdir -p $out/bin
      ln -sf ${myScript}/bin/conf-randr.sh $out/bin/conf-randr
    '';
  };
}
