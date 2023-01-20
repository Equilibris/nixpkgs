{ theme ? "onedark"
, style ? 1
, type ? 1
, pkgs ? import <nixpkgs> { }
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

    for launcher in $(ls -1 "$ROFI_DIR/launchers"); do
      sed -i "s+\$HOME/\.config/rofi+$ROFI_DIR+" "$ROFI_DIR/launchers/$launcher/launcher.sh"
      sed -i "s+'style-1'+'style-${builtins.toString style}\'+"    "$ROFI_DIR/launchers/$launcher/launcher.sh"
    done
    for rasi in $(find "$ROFI_DIR" -name '*.rasi'); do
      sed -i "s+~/.config/rofi+$ROFI_DIR+" "$rasi"
    done
    for colors in $(find "$ROFI_DIR" -type f -wholename "**/shared/colors.rasi"); do
      sed -i "s/onedark.rasi/${theme}.rasi/" "$colors"
    done

    mkdir $out/bin

    cp "$ROFI_DIR/launchers/type-${builtins.toString type}/launcher.sh" "$out/bin/wofi"
  '';
  installPhase = "true";
}

