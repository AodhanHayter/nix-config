# holds common home-manager config between both linux and macos

{ inputs, lib, config, pkgs, ...}: {

  home.shellAliases = {
    cat = "bat";
    ls = "exa";
    ll = "exa -lbhg";
    l = "exa -1a";
    ping = "prettyping --nolegend";
  };

  # Let home-manager install and manage itself
  programs.home-manager.enable = true;

  programs.password-store = {
    enable = true;

  };

  programs.exa = {
    enable = true;
  };

  programs.bat = {
    enable = true;
  };

  programs.browserpass = {
    enable = true;
  };

  programs.gpg = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
