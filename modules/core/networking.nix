{ ... }:

{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "none";
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];
  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";
  services.printing.enable = true;

  networking.firewall = { 
    enable = true;
    # allowedTCPPortRanges = [ 
    #   { from = 1714; to = 1764; } # KDE Connect
    # ];  
    # allowedUDPPortRanges = [ 
    #   { from = 1714; to = 1764; } # KDE Connect
    # ];
  };
}
