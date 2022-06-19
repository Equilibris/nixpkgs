{ config, pkgs, ... }:

let 
  manager.gnome = true;
  manager.sway = false;
in 
  ((if manager.gnome then
  {
    # Enable the X11 windowing system.
    services.xserver.enable = true;
  
    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
      [org.gnome.desktop.peripherals.touchpad]
      click-method='default'
    '';
  
    # Configure keymap in X11
    services.xserver = {
      layout = "no";
      xkbVariant = "";
    };

    environment.gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
    ]) ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
      gnome-terminal
      gedit # text editor
      epiphany # web browser
      geary # email reader
      evince # document viewer
      gnome-characters
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);
 

  } else {}) //
  (if manager.sway then
  {
    programs.sway.enable = true;
    xdg.portal.wlr.enable = true;
  } else {}))

