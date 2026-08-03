{ config, ... }:

{
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
    priority = -1;
  };

  boot.kernel.sysctl."vm.vfs_cache_pressure" = 150;

  services.journald.extraConfig = ''
    SystemMaxUse=50M
    RuntimeMaxUse=50M
  '';
}
