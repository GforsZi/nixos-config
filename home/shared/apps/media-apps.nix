{ pkgs, ... }:

{
  home.packages = with pkgs; [
    alsa-tools
    mpv
    feh
  ];
}
