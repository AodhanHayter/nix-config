{ config, pkgs, ...}: {
  environment.systemPackages = [
    pkgs.vim
  ];

  services.nix-daemon.enable = true;
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
