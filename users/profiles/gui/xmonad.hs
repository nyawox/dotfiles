import XMonad

import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.SpawnOnce
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Spacing (spacingWithEdge)
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Hooks.TaffybarPagerHints (pagerHints)

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
  , ("M-d", spawn myLauncher)
  , ("M-S-<Return>", windows W.swapMaster)
  -- Restart xmonad without recompiling. See issue nix-community/home-manager#1895
  , ("M-q", spawn "xmonad --restart")
  , ("M-w", spawn "emacsclient -c")
  , ("M-b", spawn "qutebrowser")
  , ("M-v", sendMessage (IncMasterN 1))
  , ("M-z", sendMessage (IncMasterN (-1)))
  ]
  ++
  [ (mask ++ "M-" ++ [key], screenWorkspace scr >>= flip whenJust (windows . action))
       | (key, scr)  <- zip ",.'" [0,1] -- was [0..] *** change to match your screen order ***
       , (action, mask) <- [ (W.view, "") , (W.shift, "S-")]
  ]

myStartupHook :: X ()
myStartupHook = do
    -- spawnOnce "xrandr --output DVI-I-1 --primary --scale-from 2560x1440" -- upscale to wqhd
    -- spawnOnce "xrandr --output DVI-D-0 --scale-from 2560x1440 --pos 2560x0"
    spawnOnce "taffybar"
    spawnOnce "picom --animations"
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

main :: IO ()
main = do
    xmonad . docks . ewmhFullscreen . ewmh . pagerHints $ myConfig
