{ lib, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    extraConfig = (lib.strings.fileContents ../dotfiles/tmux.conf);
  };
}

