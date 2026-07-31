{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" ]; 
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    initContent = ''
      export PATH="$HOME/.config/composer/vendor/bin:$PATH"
      source ~/.zsh-custom/tmux-autostart.sh
      export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH"
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';

     shellAliases = {
      ll = "ls -la";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    fzf
    zoxide
  ];

  home.file.".p10k.zsh".source = "${config.home.homeDirectory}/dotfiles/zsh/.p10k.zsh";
  home.file.".zsh-custom/tmux-autostart.sh".source = ./scripts/tmux-autostart.sh;
}
