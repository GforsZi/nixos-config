{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }))
    hypridle
    libnotify
    awww
    rofi
    wireplumber
    pavucontrol
    brightnessctl
    wlsunset
    grim
    slurp
    wl-clipboard
    calc
    wget
    curl
    stow
    fastfetch
    btop
    unzip
    p7zip-rar
    thunar
    thunar-archive-plugin
    papirus-icon-theme
    lxappearance
    bibata-cursors
    wlogout
  ];

  programs.hyprlock.enable = true;

  services.mako.enable = true;

  xdg.configFile = {
    "hypr".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/hyprland/.config/hypr";
    "mako".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/mako/.config/mako";
    "rofi".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/rofi/.config/rofi";
    "waybar".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/waybar/.config/waybar";
  };
}
