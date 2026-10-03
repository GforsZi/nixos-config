{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tigervnc
  ];

  services.gns3-server = {
    enable = true;
    dynamips.enable = true;
    ubridge.enable = true;
    vpcs.enable = true;
    auth.enable = false;
    settings.Server.local = true;
  };

  programs.wireshark.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
    };
  };

  programs.virt-manager.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;
}
