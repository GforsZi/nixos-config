{ pkgs, ... }:
{
  services.gns3-server = {
    enable = true;
    dynamips.enable = true;
    ubridge.enable = true;
    vpcs.enable = true;
    auth.enable = false;
  };

  programs.wireshark.enable = true;
  virtualisation.libvirtd.enable = true;

}
