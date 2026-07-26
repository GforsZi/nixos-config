{ pkgs, ... }:

{
  home.packages = with pkgs; [
    posting
  ];
}
