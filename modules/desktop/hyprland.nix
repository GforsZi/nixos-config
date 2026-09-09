{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    polkit_gnome
    sddm-astronaut
    usbutils
    lsof
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

 services.displayManager.ly = {
  enable = true;
  settings = {
    animation = "matrix";
  };
};

  security.pam.services.hyprlock = {};

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  services.logind = {
    settings = {
      Login = {
        HandleLidSwitch = "suspend";
        HandleLidSwitchExternalPower = "lock";
        IdleAction = "lock";
        IdleActionSec = "5min";
      };
    };
  };

  programs.dconf.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;
}
