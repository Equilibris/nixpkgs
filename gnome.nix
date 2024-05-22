{ config, pkgs, lib, ... }:

{
  # home.packages = with pkgs; [ gnomeExtensions.force-show-osk ];
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      "org/gnome/desktop/peripherals/keyboard".repeat = true;
      "org/gnome/desktop/input-sources".xkb-options = [ "terminate:ctrl_alt_bksp" "caps:swapescape" ];
      "org/gnome/mutter".edge-tiling = true;
      "org/gnome/settings-daemon/plugins/power".ambient-enabled = false;
    };
  };
}
