{ config, pkgs, lib, ... }:

let 
  options = import ./options.nix;
in with options;
  (lib.attrsets.optionalAttrs manager.gnome
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
  })//
  (lib.attrsets.optionalAttrs manager.sway
    (let
      # bash script to let dbus know about important env variables and
      # propogate them to relevent services run at the end of sway config
      # see
      # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
      # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts  
      # some user services to make sure they have the correct environment variables
      dbus-sway-environment = pkgs.writeTextFile {
        name = "dbus-sway-environment";
        destination = "/bin/dbus-sway-environment";
        executable = true;

        text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
          '';
      };

      # currently, there is some friction between sway and gtk:
      # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
      # the suggested way to set gtk settings is with gsettings
      # for gsettings to work, we need to tell it where the schemas are
      # using the XDG_DATA_DIR environment variable
      # run at the end of sway config
      configure-gtk = pkgs.writeTextFile {
          name = "configure-gtk";
          destination = "/bin/configure-gtk";
          executable = true;
          text = let
            schema = pkgs.gsettings-desktop-schemas;
            datadir = "${schema}/share/gsettings-schemas/${schema.name}";
          in ''
            export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
            gnome_schema=org.gnome.desktop.interface
            gsettings set $gnome_schema gtk-theme 'Nordic'
            '';
      };
    in
    {
      environment.systemPackages = with pkgs; [
        sway
        dbus-sway-environment
        configure-gtk
        wayland
        glib # gsettings
        nordic # gtk theme
        gnome3.adwaita-icon-theme  # default gnome cursors
        mako # notification system developed by swaywm maintainer
      ];

      # xdg-desktop-portal works by exposing a series of D-Bus interfaces
      # known as portals under a well-known name
      # (org.freedesktop.portal.Desktop) and object path
      # (/org/freedesktop/portal/desktop).
      # The portal interfaces include APIs for file access, opening URIs,
      # printing and others.
      services.dbus.enable = true;
      xdg.portal = {
        enable = true;
        wlr.enable = true;
        # gtk portal needed to make gtk apps happy
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
          pkgs.xdg-desktop-portal-wlr
        ];
        gtkUsePortal = true;
      };

      # enable sway window manager
      programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
      };

      location.provider = "geoclue2";
      services.redshift = {
        enable = true;
        # brightness = {
        #   # Note the string values below.
        #   day = "1";
        #   night = "1";
        # };
        # temperature = {
        #   day = 5500;
        #   night = 3700;
        # };
      };
    }))

