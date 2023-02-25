{ inputs, lib, config, pkgs, ... }: {
  environment.systemPackages = [
    pkgs.vim
  ];

  services.nix-daemon.enable = true;
  programs.zsh.enable = true;

  fonts = with pkgs; {
    fontDir.enable = true;
    fonts = [
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
  };

  homebrew = {
    enable = true;
    brews = [ "pgcli" "pyenv" "pyenv-virtualenv" "libpq" "openssl" ];
    casks = [
      "amethyst"
      "raycast"
      "spotify"
      "brave-browser"
      "itsycal"
      "docker"
      "adur1990/tap/passformacos"
    ];
  };

  system.defaults = {
    screencapture.location = "$HOME/Desktop/screenshots";
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleShowAllFiles = true;
      AppleShowScrollBars = "WhenScrolling";
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
    };
  };

  system.activationScripts.applications.text = pkgs.lib.mkForce (
    ''
      echo "setting up ~/Applications..." >&2
      rm -rf ~/Applications/Nix\ Apps
      mkdir -p ~/Applications/Nix\ Apps
      for app in $(find ${config.system.build.applications}/Applications -maxdepth 1 -type l); do
        src="$(/usr/bin/stat -f%Y "$app")"
        cp -r "$src" ~/Applications/Nix\ Apps
      done
    ''
  );

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
