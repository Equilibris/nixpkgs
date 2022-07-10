rec {
  manager.gnome = false;
  manager.sway  = true;

  useXorg = manager.gnome;
  useWayland = manager.sway;
}
