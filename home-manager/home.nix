# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors), use something like:
    # inputs.nix-colors.homeManagerModule

    # Feel free to split up your configuration and import pieces of it here.
    ./xmonad.nix
    ./git.nix
    ./tmux.nix
    ./nvim.nix
    ./alacritty.nix
    ./zsh.nix
  ];

  # Comment out if you wish to disable unfree packages for your system
  nixpkgs.config.allowUnfree = true;

  # TODO: Set your username
  home = {
    username = "aodhan";
    homeDirectory = "/home/aodhan";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    spotify
    zoom-us
    pass
    steam
    openvpn_24
    ripgrep
    mkcert
    openrgb
    slack
    (nodejs-16_x.override { enableNpm = true; })
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;

  home.shellAliases = {
    update = "sudo nixos-rebuild switch";
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
  };

  programs.bat = {
    enable = true;
  };

  programs.browserpass.enable = true;

  programs.gpg = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
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
