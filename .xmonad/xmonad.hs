import           System.IO
import           XMonad
import           XMonad.Actions.CycleWS              (toggleWS')
import           XMonad.Actions.WindowGo             (raiseEditor,
                                                      runOrRaiseNext)
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Layout.MultiToggle
import           XMonad.Layout.MultiToggle.Instances
import           XMonad.Layout.NoBorders
import qualified XMonad.StackSet                     as W
import           XMonad.Util.EZConfig
import           XMonad.Util.NamedScratchpad
import           XMonad.Util.Run                     (spawnPipe)
import           XMonad.Util.Scratchpad

main :: IO ()
main = xmonad =<< statusBar myBar myPP toggleStrutsKey (
  def { terminal = myTerminal
      , modMask = mod4Mask
      , borderWidth = 1
      , focusedBorderColor = "#4c7899"
      , normalBorderColor = "#333333"
      , manageHook = manageDocks <+> namedScratchpadManageHook myScratchpads <+> manageHook defaultConfig
      , layoutHook = avoidStruts myLayout
      , handleEventHook    = handleEventHook defaultConfig <+> docksEventHook
      , logHook = dynamicLogWithPP myPP
      } `additionalKeysP` myKeys)

-- status bar
myBar = "/usr/bin/xmobar ~/.xmobarrc"

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myPP = xmobarPP { ppTitle = xmobarColor "#657b83" "" . shorten 100
                , ppCurrent = xmobarColor "#c0c0c0" "" . wrap "" ""
                , ppSep     = xmobarColor "#c0c0c0" "" " | "
                , ppUrgent  = xmobarColor "#ff69b4" ""
                , ppLayout = const "" -- to disable the layout info on xmobar
                }


-- terminal
myTerminal = "termite"

-- TODO: implement spawning windows besides and below
myKeys = [ ("M-s", scratchPad)
         , ("M-f", sendMessage $ Toggle FULL)
         , ("M-c", runOrRaiseNext "chromium" (className =? "Chromium"))
         , ("M-S-c", spawn "chromium")
         , ("M-e", runOrRaiseNext "emacsclient -c" (className =? "Emacs"))
         , ("M-S-e", spawn "emacsclient -c")
         , ("M-S-x", spawn "lock -f Arimo && systemctl suspend")
         , ("M-S-l", spawn "lock -f Arimo")
         , ("M-o", toggleWS' ["NSP"])
         , ("M-S-q", kill)
         , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+")
         , ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%-")
         -- TODO: Find a less dumb way of toggling mute
         --, ("<XF86AudioMute>", spawn "amixer set Master toggle;\
                                     --amixer set Headphone toggle;\
                                     --amixer set Front toggle;\
                                     --amixer set Master toggle;\
                                     --amixer set Headphone toggle;\
                                     --amixer set Front toggle")
         ]
  where scratchPad = namedScratchpadAction myScratchpads "scratchpad" --TODO: get termite working here

myScratchpads :: [NamedScratchpad]
myScratchpads = [NS "scratchpad" "termite --title scratchpad" (title =? "scratchpad") myScratchpadHook]
  where myScratchpadHook = customFloating (W.RationalRect l t w h)
        h = 0.7
        w = 0.7
        t = (1-h)/2
        l = (1-w)/2


myLayout = id
  .smartBorders
  .mkToggle (NOBORDERS ?? FULL ?? EOT)
  $ tiled ||| Mirror tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100
