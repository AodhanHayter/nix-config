{ config, pkgs, ...}: {
  services.dunst = {
    enable = false;

    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome3.adwaita-icon-theme;
      size = "16x16";
    };

    settings = {
      global = {
        monitor = 0;
        geometry = "600x50-50+65";
        shrink = "yes";
        padding = 16;
        horizontal_padding = 16;
        line_height = 4;
        format = ''<b>%s</b>/n%b'';
      };
    };
  };
}
