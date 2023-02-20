{ config, pkgs, ... }:

{
  console = {
    packages = with pkgs; [ terminus_font ];
    font = "ter-i32b";
    keyMap = "no";
    #   earlySetup = true;
    #   font = "FiraCode Nerd Font";
    #   packages = [ (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; }) ];
    # colors = [
    #   "002b36" ### 01 ### 0 & 1
    #   "dc322f" ### 02 ### 2
    #   "859900" ### 03 ### 3
    #   "b58900" ### 04 ### 4
    #   "268bd2" ### 05 ### 5
    #   "d33682" ### 06 ### 6
    #   "2aa198" ### 07 ### 7
    #   "eee8d5" ### 08 ### 8
    #   "002b36" ### 01
    #   "cb4b16" ### 10
    #   "586e75" ### 11
    #   "657b83" ### 12
    #   "839496" ### 13
    #   "6c71c4" ### 14
    #   "93a1a1" ### 15
    #   "fdf6e3" ### 16
    # ];
    # colors = [ 002b36-dc322f-859900-b58900-268bd2-d33682-2aa198-eee8d5-002b36-cb4b16-586e75-657b83-839496-6c71c4-93a1a1-fdf6e3-];
    # colors = [
    #   "FF0000"
    #   "FF0000"
    #   "FF0000"
    #   "FF0000"
    #   "FF0000"
    #   "FF0000"
    #   "00FF00"
    #   "00FF00"
    #   "00FF00"
    #   "00FF00"
    #   "00FF00"
    #   "00FF00"
    #   "00FF00"
    #   "0000FF"
    #   "0000FF"
    #   "0000FF"
    #   "0000FF"
    # ];
    # colors = [
    #   "0000FF"
    #   "0000FF"
    #   "0000FF"
    #   "0000FF"
    #   "FF0000"
    #   "FF0000"
    #   "FF0000"
    #   "00FF00"
    #   "00FF00"
    #   "00FF00"
    #   "FF0000"
    #   "FF0000"
    #   "FF0000"
    #   "00FF00" 
    #   "00FF00"
    #   "00FF00"
    #   "00FF00"
    # ];
    # colors = [
    #   "2E3440"
    #   "3B4252"
    #   "434C5E"
    #   "4C566A"
    #   "D8DEE9"
    #   "E5E9F0"
    #   "ECEFF4"
    #   "8FBCBB"
    #   "88C0D0"
    #   "81A1C1"
    #   "5E81AC"
    #   "BF616A"
    #   "D08770"
    #   "EBCB8B"
    #   "A3BE8C"
    #   "B48EAD"
    # ];
  };
}
