{ pkgs, lib, ...}: {
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    extraPackages = hp: [
      hp.dbus
      hp.xmonad
      hp.monad-logger
    ];
    config = ./config.hs;
  };
}
