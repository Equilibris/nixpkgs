{ theme ? "onedark",
  style ? "1",
  type ? "1",
  pkgs ? import <nixpkgs> {}
}:
let
  stdenv = pkgs.stdenv;
in
  stdenv.mkDerivation {
    name = "rofi-themes";

    src = pkgs.fetchFromGitHub {
      owner = "adi1090x";
      repo = "rofi";
      # rev = "307deb9b9203a0f3d343c98f87d96eefa2a7ae96";
      # sha256 = "sha256-NocMC9tkoG7HysM1PegY+9JOc1GtYo+b5GHah8rZCHM=";
      rev = "7f07d4da1cf2d30e48cf1749e56b5cffed247e6f";
      sha256 = "sha256-aZcX6PLGrds9LZhSb81cNHCA5nZWHla0hxHd92Dj42g=";
    };
    buildPhase = ''
      ROFI_DIR=$out
      DIR=`pwd`

      echo -e "[*] Installing rofi configs..."
      { mkdir -p "$ROFI_DIR"; cp -rf $DIR/files/* "$ROFI_DIR"; }
    '';
    installPhase = "true";
  }

