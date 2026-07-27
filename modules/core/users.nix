{ config, pkgs, ... }:

{
  users.users."gfors" = {
    isNormalUser = true;
    description = "nixos";
    extraGroups = [" docker" "networkmanager" "wheel" "video" "render"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
    ];
  };
  programs.zsh.enable = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    priority = -1;
    };

}
