{ inputs, lib, config, pkgs, ...}: {
  environment.systemPackages = [
    pkgs.vim
  ];

  services.nix-daemon.enable = true;
  programs.zsh.enable = true;

  fonts = with pkgs; {
    fontDir.enable = true;
    fonts = [
      (nerdfonts.override { fonts = ["FiraCode"]; })
    ];
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
