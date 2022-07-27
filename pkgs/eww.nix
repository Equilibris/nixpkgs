{ pkgs ? import <nixpkgs> {}
, withWayland ? true
}:

let
 lib = pkgs.lib;
 rustPlatform = pkgs.rustPlatform;
 fetchFromGitHub = pkgs.fetchFromGitHub;
 pkg-config = pkgs.pkg-config;
 gtk3 = pkgs.gtk3;
 gtk-layer-shell = pkgs.gtk-layer-shell;
 stdenv = pkgs.stdenv;
in
  rustPlatform.buildRustPackage rec {
    pname = "eww";
    version = "0.3.0";

    src = fetchFromGitHub {
      owner = "elkowar";
      repo = pname;
      rev = "v${version}";
      sha256 = "055il2b3k8x6mrrjin6vkajpksc40phcp4j1iq0pi8v3j7zsfk1a";
    };

    cargoSha256 = "sha256-3hGA730g8E4rwQ9V0wSLUcAEmockXi+spwp50cgf0Mw=";

    cargoPatches = [ ./eww.Cargo.lock.patch ];

    nativeBuildInputs = [ pkg-config ];

    buildInputs = [ gtk3 ] ++ lib.optional withWayland gtk-layer-shell;

    buildNoDefaultFeatures = withWayland;
    buildFeatures = lib.optional withWayland "wayland";

    cargoBuildFlags = [ "--bin" "eww" ];

    cargoTestFlags = cargoBuildFlags;

    # requires unstable rust features
    RUSTC_BOOTSTRAP = 1;

    meta = with lib; {
      description = "ElKowars wacky widgets";
      homepage = "https://github.com/elkowar/eww";
      license = licenses.mit;
      maintainers = with maintainers; [ figsoda lom ];
      broken = stdenv.isDarwin;
    };
  }
