{ pkgs, config, ... }: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
  };

  xdg.configFile = {
    "yazi".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/yazi/.config/yazi";
  };
}
