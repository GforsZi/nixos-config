{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (pkgs.symlinkJoin {
      name = "vesktop";
      paths = [ pkgs.vesktop ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/vesktop \
          --add-flags "--enable-features=UseOzonePlatform,VAAPI --ozone-platform=wayland --ignore-gpu-blocklist"
      '';
    })
  ];
}
