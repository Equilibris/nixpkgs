{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    obsidian
    (python3.withPackages (p: with p; [ 
      pynvim
      jupyter_client
      ueberzug
      cairosvg
      pnglatex
      plotly # python312Packages.kaleido
      pyperclip

      numpy
      matplotlib
    ]))

    xournalpp
  ];
}
