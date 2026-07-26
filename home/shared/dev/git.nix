{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "GforsZi";
      user.email = "givaldigumelarsetiawan@gmail.com";
      init.defaultBranch = "main";
    };
  };
}
