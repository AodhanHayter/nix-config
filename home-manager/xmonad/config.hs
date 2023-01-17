import XMonad
import XMonad.Util.EZConfig (additionalKeys)

myKeys conf@(XConfig { modMask = modKey }) =
  [ ((modKey, xK_p), spawn "rofi -show combi -modes combi -combi-modes \"window,drun,run\" -show-icons")]

myConfig = def
  { terminal = "alacritty"
  , modMask = mod4Mask
  , borderWidth = 3
  }

myConfig' = myConfig `additionalKeys` (myKeys myConfig)

main = xmonad myConfig'

