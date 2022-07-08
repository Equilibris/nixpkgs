rec {
  manager.gnome = true;
  manager.sway  = false;

  useXorg = manager.gnome;
  useWayland = manager.sway;
}
