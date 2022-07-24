{ 
  pkgs ? import <nixpkgs> {},
}:

let
  inherit (pkgs.lib.lists) foldr;
  inherit (pkgs.lib.attrsets) mapAttrsToList;

  # Helper functions
  pipeConcat = foldr (a: b: a + "|" + b) "";
  lineBreakConcat = foldr (a: b: a + "\n" + b) "";
  boolToString = x: if x then "1" else "0";
  makeLnCommands = type: (mapAttrsToList (name: path: "ln -sf ${path} ./${type}/${name}"));

  # Setup spicetify
  spicetifyPkg = pkgs.spicetify-cli;
  spicetify = "SPICETIFY_CONFIG=. ${spicetifyPkg}/bin/spicetify-cli";

  themes = pkgs.fetchFromGitHub {
    owner = "spicetify";
    repo = "spicetify-themes";

    rev = "0dd8243d4e25f142c3f62a8d3da8f6647dbf64e4";
    
  };

  theme = "Sleek";
  scheme = "Nord";
in
pkgs.spotify-unwrapped.overrideAttrs (oldAttrs: rec {
  postInstall=''
    touch $out/prefs
    mkdir Themes
    mkdir Extensions
    mkdir CustomApps
    find ${themes} -maxdepth 1 -type d -exec ln -s {} Themes \;

    ${spicetify} config \
      spotify_path "$out/share/spotify" \
      prefs_path "$out/prefs" \
      current_theme ${theme} \
      current_scheme ${scheme} \
    ${spicetify} backup apply
  '';
})
