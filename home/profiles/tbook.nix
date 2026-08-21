{ ... }:

{
  imports = [
  ../shared/common/hyprland.nix

  ../shared/apps/spotify.nix
  ../shared/apps/vesktop.nix
  ../shared/apps/alsa-tools.nix
  ../shared/apps/browsers.nix
  ../shared/apps/tor-browser.nix
  ../shared/apps/mpv.nix
  ../shared/apps/obs.nix
  ../shared/apps/gimp.nix
  ../shared/apps/zoom-us.nix

  ../shared/shell/tmux.nix
  ../shared/shell/zsh.nix

  ../shared/terminal/kitty.nix
  
  ../shared/cli-tools/opencode.nix
  ../shared/cli-tools/yazi.nix
  ../shared/cli-tools/ffmpeg.nix
  ../shared/cli-tools/ngrok.nix
  ../shared/cli-tools/posting.nix

  ../shared/dev/direnv.nix
  ../shared/dev/gcc.nix
  ../shared/dev/git.nix
  ../shared/dev/nodejs.nix
  ../shared/dev/php.nix
  ../shared/dev/go.nix
  ../shared/dev/python.nix

  ../shared/editor/neovim.nix
  ];

  home.stateVersion = "26.05";
  home.username = "gfors";
  home.homeDirectory = "/home/gfors";
}
