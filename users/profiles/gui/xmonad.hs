import XMonad

import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.SpawnOnce
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageDocks (avoidStruts, manageDocks)
import XMonad.Layout.Spacing (spacingWithEdge)
import XMonad.Layout.NoBorders (smartBorders)

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myTerminal = "alacritty"
myBorderWidth = 6
myModMask = mod4Mask
myLauncher = "rofi -show run"
myFocusedColor = "#bf5f82"
myBorderColor = "#212121"

myLayout = spacingWithEdge 10 $ smartBorders $ avoidStruts (tiled ||| Mirror tiled ||| Full)
  where
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes

myKeys =
  [ ("M-<Return>", spawn myTerminal)
  , ("M-p", spawn myLauncher)
  , ("M-S-<Return>", windows W.swapMaster)
  -- Restart xmonad without recompiling. See issue nix-community/home-manager#1895
  , ("M-q", spawn "xmonad --restart")
  , ("M-w", spawn "emacsclient -c")
  , ("M-b", spawn "qutebrowser")
  ]

myStartupHook :: X ()
myStartupHook = do
    spawnOnce "xrandr --output DVI-I-3 --scale-from 2560x1440" -- upscale to wqhd
    spawnOnce "picom --experimental-backend"
    spawnOnce "feh --bg-fill ~/.wallpaper"

myConfig = def
        { terminal           = myTerminal
        , modMask            = myModMask
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myBorderColor
        , focusedBorderColor = myFocusedColor
        , startupHook        = myStartupHook
        , layoutHook         = myLayout
        , manageHook         = manageDocks <+> manageHook defaultConfig
        } `additionalKeysP` myKeys

mySB = statusBarProp "xmobar" (pure xmobarPP)

main :: IO ()
main = do
    xmonad . ewmhFullscreen . ewmh . withSB mySB $ myConfig
