{ config, lib, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.resumeDevice = lib.mkIf (config.swapDevices != []) (lib.head config.swapDevices).device;
  boot.kernelParams = lib.mkIf (config.swapDevices != []) [ "resume=${(lib.head config.swapDevices).device}" ];

  boot.kernel.sysctl = {
    "vm.swappiness" = 100;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
  };

}
