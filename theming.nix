{ config
, pkgs
, lib
, ...
}:
let
  nord =
    {
      nvim-name = "nord";

      kitty = builtins.readFile "${
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/connorholyday/nord-kitty/master/nord.conf";
          sha256 = "4R5wNmrP2JkIW9t603AmJEcHJUQ/RYw7NwuvmrJhdrk=";
        }
      }";

      gtk = {
        name = "Nordic";
        package = pkgs.nordic;
        icons = pkgs.gnome3.adwaita-icon-theme;
      };

      rofi-themes = import ../pkgs/rofi-themes.nix {
        theme = "nord";
        style = 15;
        type = 1;
      };
    };

  catppuccin =

    let
      gtk-pkg = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ]; # You can specify multiple accents here to output multiple themes
        size = "compact";
        tweaks = [ ]; # You can also specify multiple tweaks here
        variant = "mocha";
      };
      gtk-name = "Catppuccin-Mocha-Compact-Pink-Dark";
    in

    {
      nvim-name = "catppuccin";

      kitty = builtins.readFile "${
      pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/kitty/d7d61716a83cd135344cbb353af9d197c5d7cec1/themes/mocha.conf";
        sha256 = "sha256-MGte5LelzzdM9SL+zFC4agVfFcluVVYaq/+fKopyON4=";
      }
    }";

      gtk = {
        name = "Catppuccin-Mocha-Compact-Pink-Dark";
        package = gtk-pkg;
        icons = pkgs.gnome3.adwaita-icon-theme;
      };

      rofi-themes = import ../pkgs/rofi-themes.nix {
        theme = "nord";
        style = 15;
        type = 1;
      };
      gtk-css = builtins.readFile "${gtk-pkg}/share/themes/${gtk-name}/gtk-4.0/gtk-dark.css";
      files =
        let dir = "${gtk-pkg}/share/themes/${gtk-name}/gtk-4.0";
        in
        {
          ".config/gtk-4.0/assets/" = {
            source = config.lib.file.mkOutOfStoreSymlink "${dir}/assets/";
            recursive = true;
          };
          ".config/gtk-4.0/gtk-dark.css" = {
            source = config.lib.file.mkOutOfStoreSymlink "${dir}/gtk-dark.css";
          };
          ".config/gtk-4.0/gtk.css" = {
            source = config.lib.file.mkOutOfStoreSymlink "${dir}/gtk-dark.css";
          };
          ".config/gtk-4.0/thumbnail.png" = {
            source = config.lib.file.mkOutOfStoreSymlink "${dir}/thumbnail.png";
          };
        };
    };
in
catppuccin
