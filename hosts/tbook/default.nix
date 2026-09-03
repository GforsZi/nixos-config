# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      ../../modules/core/boot.nix
      ../../modules/core/nix-settings.nix
      ../../modules/core/networking.nix
      ../../modules/core/nix-ld.nix
      ../../modules/core/users.nix
      ../../modules/core/power-profiles-daemon.nix
      ../../modules/core/thermald.nix

      ../../modules/hardware/audio.nix
      ../../modules/hardware/intel-graphics.nix
      ../../modules/hardware/bluetooth.nix
      ../../modules/hardware/memory.nix

      ../../modules/desktop/hyprland.nix

      ../../modules/services/ssh.nix
      ../../modules/services/docker.nix
      ../../modules/services/mysql.nix
      ../../modules/services/flatpak.nix
    ];


  system.stateVersion = "26.05"; # Did you read the comment?

}
