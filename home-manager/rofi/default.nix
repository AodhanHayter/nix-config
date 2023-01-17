{ pkgs, ...}: {
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    pass.enable = true;
    theme = ./theme.rafi;
  };
}
