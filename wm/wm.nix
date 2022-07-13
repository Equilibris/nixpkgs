{ config
, pkgs
, lib
, ... }:

let
  eww = 
    # pkgs.eww.override{ withWayland = true; };
    pkgs.rustPlatform.buildRustPackage rec {
      pname = "eww";
      version = "0.2.0";

      src = pkgs.fetchFromGitHub {
        owner = "elkowar";
        repo = pname;
        rev = "v0.3.0";
        sha256 = "sha256-Kkyn/5Fjo3gBjkGSy+AFhOl5pZrb2ChzrqajOZagsRQ=";
      };

      # cargoSha256 = "sha256-LejnTVv9rhL9CVW1fgj2gFv4amHQeziu5uaH2ae8AAw=";
      cargoSha256 = "sha256-PhbZqY5CBCXB95ovmBLq01A7C6juLRp07oe4TgaLAx4=";
      # cargoLock = {};

      nativeBuildInputs = [ pkgs.pkg-config ];

      buildInputs = with pkgs; [ gtk3 gtk-layer-shell ];

      buildNoDefaultFeatures = true;
      buildFeatures = "wayland";

      cargoBuildFlags = [ "--bin" "eww" ];

      cargoTestFlags = cargoBuildFlags;

      # requires unstable rust features
      RUSTC_BOOTSTRAP = 1;
    };
in
  {
    home.packages = [ eww ] ++ (with pkgs; [ 
      rofi
      slurp grim
      xclip wl-clipboard
      tmux
      fnott libnotify
    ]);

    home.file = {
      ".config/sway/config" = {
        source = config.lib.file.mkOutOfStoreSymlink ./sway.config;
      };
      ".config/fnott/fnott.ini" = {
        source = config.lib.file.mkOutOfStoreSymlink ./fnott.ini;
      };
      "walls/nordic/nixos.png" = {
        source = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/linuxdotexe/nordic-wallpapers/master/wallpapers/nixos.png";
          sha256 = "sha256-jB7q1PAMKS0tfk0Ck6pGkbsfwO+7FHwI83dUHO86ftM=";
        };
      };
    };
  }

