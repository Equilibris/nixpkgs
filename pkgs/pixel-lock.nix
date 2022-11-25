{ pkgs ? import <nixpkgs> {} }:
let
  stdenv = pkgs.stdenv;
  src = pkgs.writeShellScript "pixel-lock" ''
    # based on
    # https://github.com/JacobErnst98/i3-Pixel-Lock/blob/master/lock
    LOCK_IMG="/tmp/pixellock-$(date +%s).png"
    SNAPSHOT_CMD="grim $LOCK_IMG"

    # SCALE2 / SCALE1 = 1

    SCALE1="10%" SCALE2="1000%"

    $SNAPSHOT_CMD
    convert $LOCK_IMG -scale $SCALE1 -scale $SCALE2 $LOCK_IMG
    swaylock -i $LOCK_IMG
    rm $LOCK_IMG
  '';
in
  stdenv.mkDerivation {
    name = "pixel-lock";

    src = src;

    nativeBuildInputs = [ pkgs.imagemagick pkgs.grim ];

    unpackPhase = "true";
    buildPhase = "true";
    installPhase = ''
      mkdir $out
      mkdir $out/bin
      cp $src  $out/bin/pixel-lock
      chmod +x $out/bin/pixel-lock
    '';
  }
