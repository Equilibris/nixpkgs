{ config, pkgs, lib, ... }:

let
  unstable = import <nixos-unstable> { };

  manager.gnome = false;
  manager.i3 = false;

  manager.sway = true;
  manager.hyprland = true;
  wayland = true;

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
    text =
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in
      ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'Nordic'
      '';
  };


  flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
  hyprland = (import flake-compat {
    src = builtins.fetchTarball "https://github.com/hyprwm/Hyprland/archive/master.tar.gz";
  }).defaultNix;

  waylandOverlay =
    let
      rev = "master"; # 'rev' could be a git rev, to pin the overlay.
      url = "https://github.com/nix-community/nixpkgs-wayland/archive/${rev}.tar.gz";
    in
    (import "${builtins.fetchTarball url}/overlay.nix");
in
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
  }) //

(lib.attrsets.optionalAttrs wayland {
  environment.systemPackages = with pkgs; [
    configure-gtk
    wayland
    glib # gsettings
    nordic # gtk theme
    gnome3.adwaita-icon-theme # default gnome cursors
    mako # notification system developed by swaywm maintainer
    xwayland
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
}) //
(lib.attrsets.optionalAttrs manager.sway
  {
    environment.systemPackages = with pkgs; [
      sway
      dbus-sway-environment
    ];

    # enable sway window manager
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
  }
) //
(lib.attrsets.optionalAttrs manager.hyprland {
  imports = [
    hyprland.nixosModules.default
  ];

  # nixpkgs.overlays = [ waylandOverlay ];
  # environment.systemPackages = with pkgs; [ wlroots ];

  programs.hyprland = {
    enable = true;
    package = hyprland.packages.${pkgs.system}.default;

    xwayland = {
      enable = true;
      hidpi = true;
    };
    nvidiaPatches = true;
  };

  hardware.video.hidpi.enable = true;
}) //
(lib.attrsets.optionalAttrs manager.i3 {
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3lock #default i3 screen locker
      ];
    };
  };
})
