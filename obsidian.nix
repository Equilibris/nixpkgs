{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    obsidian
    python312

    xournalpp
    neo4j-desktop
  ];
}
