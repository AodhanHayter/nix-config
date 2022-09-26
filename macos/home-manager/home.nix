# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ...}: {
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors), use something like:
    # inputs.nix-colors.homeManagerModule

    # Feel free to split up your configuration and import pieces of it here.
    ../../home-manager/git.nix
    ../../home-manager/tmux.nix
    ../../home-manager/nvim.nix
    ../../home-manager/alacritty.nix
    ../../home-manager/zsh.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "ahayter";
    homeDirectory = "/Users/ahayter";
  };

  home.packages = with pkgs; [
    pass
    ripgrep
    mkcert
    (nodejs-16_x.override { enableNpm = true; })
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
