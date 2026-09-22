{ pkgs, ... }:

{
  home.packages = with pkgs; [
    brave
    tor-browser
  ];

  xdg.configFile."BraveSoftware/Brave-Browser/policies/managed/custom-policy.json".text = builtins.toJSON {
    DefaultSearchProviderEnabled = true;
    DefaultSearchProviderSearchURL = "https://www.google.com/search?q={searchTerms}";
    PasswordManagerEnabled = false;
    BraveRewardsDisabled = true;
    BraveWalletDisabled = true;
  };
}
