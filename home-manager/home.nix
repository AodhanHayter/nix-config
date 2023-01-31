# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors), use something like:
    # inputs.nix-colors.homeManagerModule

    # Feel free to split up your configuration and import pieces of it here.
    ./common.nix
    # ./xmonad
    ./obs.nix
    ./git.nix
    ./tmux.nix
    ./nvim.nix
    ./alacritty.nix
    ./zsh.nix
    # ./rofi
    # ./dunst.nix
  ];

  # Comment out if you wish to disable unfree packages for your system
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "aodhan";
    homeDirectory = "/home/aodhan";
  };

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [
    spotify
    zoom-us
    steam
    openvpn_24
    ripgrep
    mkcert
    openrgb
    slack
    (nodejs-16_x.override { enableNpm = true; })
    prettyping
    rnix-lsp
  ];

  home.shellAliases = {
    update = "sudo nixos-rebuild switch";
  };

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    enableSshSupport = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.05";
}
