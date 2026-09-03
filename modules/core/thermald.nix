{ config, pkgs, ... }:

{
  services.thermald.enable = true;

  systemd.services.thermald.unitConfig.ConditionACPower = false;

  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", KERNEL=="ADP1", ATTR{online}=="0", RUN+="${pkgs.systemd}/bin/systemctl start thermald.service"
    SUBSYSTEM=="power_supply", KERNEL=="ADP1", ATTR{online}=="1", RUN+="${pkgs.systemd}/bin/systemctl stop thermald.service"
  '';
}
