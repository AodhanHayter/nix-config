{ pkgs, lib, ...}: {
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    extraPackages = haskellPackages: [
      haskellPackages.xmonad
      haskellPackages.monad-logger
    ];
    config = pkgs.writeText "xmonad.hs" ''
      import XMonad
      main = xmonad defaultConfig
        { terminal = "alacritty"
        , modMask  = mod4Mask
        , borderWidth = 3
        }
    '';
  };
}
