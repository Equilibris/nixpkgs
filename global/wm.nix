{ enable-i3 ? false
, enable-sway ? false
, enable-gnome ? false
, enable-hyprland ? false
, enable-wayland ? false
,
}: { config, pkgs, lib, hyprland, unstable, ... }:
let

  theming =
    (import ../theming.nix) { inherit config; inherit pkgs; inherit lib; };
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

  # xdg-desktop-portal-hyprland = inputs.xdph.packages.${prev.system}.default.override {
  #   hyprland-share-picker = inputs.xdph.packages.${prev.system}.hyprland-share-picker.override { inherit hyprland; };
  # };

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



  # waylandOverlay =
  #   let
  #     rev = "master"; # 'rev' could be a git rev, to pin the overlay.
  #     url = "https://github.com/nix-community/nixpkgs-wayland/archive/${rev}.tar.gz";
  #   in
  #   (import "${builtins.fetchTarball url}/overlay.nix");
in
(lib.attrsets.optionalAttrs enable-wayland {
  environment.systemPackages = with pkgs; [
    configure-gtk
    wayland
    glib # gsettings
    (theming.gtk.package) # gtk theme
    (theming.gtk.icons) # default gnome cursors
    xwayland
    gtk3
    gtk4
  ];

  # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name
  # (org.freedesktop.portal.Desktop) and object path
  # (/org/freedesktop/portal/desktop).
  # The portal interfaces include APIs for file access, opening URIs,
  # printing and others.
  # environment.variables.GTK_USE_PORTAL = "1";
  environment.variables.GDK_BACKEND = "x11";
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      # pkgs.xdg-desktop-portal-wlr
    ];
  };


  location.provider = "geoclue2";
}) //
(lib.attrsets.optionalAttrs enable-sway
  {
    environment.systemPackages = with pkgs; [
      sway
      dbus-sway-environment
    ];

    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
  }
) //
(lib.attrsets.optionalAttrs enable-gnome
  {
    # Enable the X11 windowing system.
    services.xserver = {
      enable = true;

      # Enable the GNOME Desktop Environment.
      displayManager = {
        gdm.enable = true;
        # defaultSession = "gnome";
        autoLogin = {
          enable = false;
          user = "williams";
        };
      };
      desktopManager.gnome.enable = true;
      desktopManager.gnome.extraGSettingsOverrides = ''
        [org.gnome.desktop.peripherals.touchpad]
        click-method='default'
      '';

      # Configure keymap in X11
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

    services.dbus.enable = true;

    xdg.portal = {
      enable = true;
      wlr.enable = false;
      # gtk portal needed to make gtk apps happy
      extraPortals = [
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-wlr
      ];
    };
  }) //
(lib.attrsets.optionalAttrs enable-hyprland {
  # nixpkgs.overlays = [ waylandOverlay ];
  # environment.systemPackages = with pkgs; [ wlroots ];

  programs.hyprland = {
    enable = true;

    xwayland = {
      enable = true;
    };
    # enableNvidiaPatches = true;
  };
}) //
(lib.attrsets.optionalAttrs enable-i3 {
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

