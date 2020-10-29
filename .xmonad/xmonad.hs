-- Base
import XMonad
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

    -- Actions
import XMonad.Actions.CopyWindow (kill1, killAllOtherCopies)
import XMonad.Actions.CycleWS (moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (sinkAll, killAll)
import qualified XMonad.Actions.Search as S
import XMonad.Actions.CycleWS (moveTo, shiftTo, WSType(..), nextScreen, prevScreen, shiftNextScreen)

    -- Data
import Data.Char (isSpace)
import Data.Monoid
import Data.Maybe (isJust)
import qualified Data.Map as M

    -- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WorkspaceHistory

    -- Layouts
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.IndependentScreens

    -- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed (renamed, Rename(Replace))
import XMonad.Layout.Spacing
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

    -- Prompt
import XMonad.Prompt
import XMonad.Prompt.Input
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Man
import XMonad.Prompt.Pass
import XMonad.Prompt.Shell (shellPrompt)
import XMonad.Prompt.Ssh
import XMonad.Prompt.XMonad
import Control.Arrow (first)

    -- Utilities
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce

    -- Theme
import Colors

myFont :: String
myFont = "xft:Monospace:pixelsize=21"

myModMask :: KeyMask
myModMask = mod4Mask       -- Sets modkey to super/windows key

myTerminal :: String
myTerminal = "kitty"   -- Sets default terminal

myBrowser :: String
myBrowser = "qutebrowser "               -- Sets qutebrowser as browser for tree select

myEditor :: String
myEditor = "emacsclient -c -a emacs"  -- Sets emacs as editor for tree select

myBorderWidth :: Dimension
myBorderWidth = 1          -- Sets border width for windows

myNormColor :: String
myNormColor = Colors.background

myFocusColor :: String
myFocusColor = Colors.color1

altMask :: KeyMask
altMask = mod1Mask         -- Setting this for use in xprompts

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myStartupHook :: X ()
myStartupHook = do
          spawnOnce "/home/gabe/.scripts/startup"
          setWMName "LG3D"

dtXPConfig :: XPConfig
dtXPConfig                  = def
      { font                = myFont
      , bgColor             = Colors.background
      , fgColor             = Colors.foreground
      , bgHLight            = Colors.color7
      , fgHLight            = Colors.color2
      , borderColor         = Colors.color3
      , promptBorderWidth   = 0
      , promptKeymap        = dtXPKeymap
      , position            = Top
--    , position            = CenteredAt { xpCenterY = 0.3, xpWidth = 0.3 }
      , height              = 45
      , historySize         = 256
      , historyFilter       = id
      , defaultText         = []
      -- , autoCoplete      = Just 100000  -- set Just 100000 for .1 sec
      , showCompletionOnTab = False
      -- , searchPredicate  = isPrefixOf
      , searchPredicate     = fuzzyMatch
      , alwaysHighlight     = True
      , maxComplRows        = Nothing      -- set to Just 5 for 5 rows
      }

-- The same config above minus the autocomplete feature which is annoying
-- on certain Xprompts, like the search engine prompts.
dtXPConfig' :: XPConfig
dtXPConfig'          = dtXPConfig
      { autoComplete = Nothing
      }

dtXPKeymap :: M.Map (KeyMask,KeySym) (XP ())
dtXPKeymap = M.fromList $
     map (first $ (,) controlMask)   -- control + <key>
     [ (xK_z, killBefore)            -- kill line backwards
     , (xK_k, killAfter)             -- kill line forwards
     , (xK_a, startOfLine)           -- move to the beginning of the line
     , (xK_e, endOfLine)             -- move to the end of the line
     , (xK_m, deleteString Next)     -- delete a character foward
     , (xK_b, moveCursor Prev)       -- move cursor forward
     , (xK_f, moveCursor Next)       -- move cursor backward
     , (xK_BackSpace, killWord Prev) -- kill the previous word
     , (xK_y, pasteString)           -- paste a string
     , (xK_g, quit)                  -- quit out of prompt
     , (xK_bracketleft, quit)
     ]
     ++
     map (first $ (,) altMask)       -- meta key + <key>
     [ (xK_BackSpace, killWord Prev) -- kill the prev word
     , (xK_f, moveWord Next)         -- move a word forward
     , (xK_b, moveWord Prev)         -- move a word backward
     , (xK_d, killWord Next)         -- kill the next word
     , (xK_n, moveHistory W.focusUp')   -- move up thru history
     , (xK_p, moveHistory W.focusDown') -- move down thru history
     ]
     ++
     map (first $ (,) 0) -- <key>
     [ (xK_Return, setSuccess True >> setDone True)
     , (xK_KP_Enter, setSuccess True >> setDone True)
     , (xK_BackSpace, deleteString Prev)
     , (xK_Delete, deleteString Next)
     , (xK_Left, moveCursor Prev)
     , (xK_Right, moveCursor Next)
     , (xK_Home, startOfLine)
     , (xK_End, endOfLine)
     , (xK_Down, moveHistory W.focusUp')
     , (xK_Up, moveHistory W.focusDown')
     , (xK_Escape, quit)
     ]

myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "term" spawnTerm (resource =? "dropdown-terminal") (manageRightThird)
                 ,NS "pavu" "pavucontrol" (className =? "Pavucontrol") (manageThirdscreen)
                 ,NS "signal" "signal-desktop-beta" (resource =? "signal beta") (manageFullscreen)
                 ,NS "py" "kitty --name=dropdown-py python" (resource =? "dropdown-py") (manageRightThird)
                 ,NS "emacsclient" "emacsclient --alternate-editor='' --no-wait --create-frame --frame-parameters='(quote (name . \"note-emacs\"))' ~/docs/Org/notes.org" (title =? "note-emacs") (manageCenter)
                 ,NS "browser" "qutebrowser --basedir ~/.config/scratchbrowser --config-py ~/.config/qutebrowser/config.py --qt-arg name qutepad" (resource =? "qutepad") (manageCenter)
                 ,NS "discord" "discord" (resource =? "discord") (manageCenter)
                 ,NS "barpad1" "kitty --name=barpad1 --config=/home/gabe/.config/kitty/sml-kitty.conf /home/gabe/.scripts/less-wtr" (resource =? "barpad1") (manageBar1)
                 ,NS "barpad2" "kitty --name=barpad2 --config=/home/gabe/.config/kitty/sml-kitty.conf tty-clock" (resource =? "barpad2") (manageBar2)
                 ,NS "barpad3" "kitty --name=barpad3 --config=/home/gabe/.config/kitty/sml-kitty.conf vtop" (resource =? "barpad3") (manageBar3)
                 ,NS "neopad" "kitty --name=neopad nvim" (resource =? "neopad") (manageCenter)
                 ,NS "ranger" "kitty --name=rangerpad ranger" (resource =? "rangerpad") (manageCenterSml)
                ]
  where
    spawnTerm = myTerminal ++ " --name=dropdown-terminal"
    findTerm  = resource =? "dropdown-terminal"

manageBar1   = customFloating $ W.RationalRect l t w h
  where
    h             = 0.29
    w             = 0.46
    t             = 0.97 -h
    l             = 0.98 -w
manageBar2   = customFloating $ W.RationalRect l t w h
  where
    h             = 0.14
    w             = 0.13
    t             = 0.03
    l             = 0.97 -w
manageBar3   = customFloating $ W.RationalRect l t w h
  where
    h             = 0.29
    w             = 0.46
    t             = 0.97 -h
    l             = 0.03
manageRightHalf   = customFloating $ W.RationalRect l t w h
  where
    h             = 0.94
    w             = 1/2
    t             = 0.03
    l             = 0.98 -w
manageRightThird  = customFloating $ W.RationalRect l t w h
  where
    h             = 0.94
    w             = 1/3
    t             = 0.03
    l             = 0.98 -w
manageFullscreen  = customFloating $ W.RationalRect l t w h
  where
    h             = 0.96
    w             = 0.98
    t             = 0.02
    l             = 0.01
manageThirdscreen = customFloating $ W.RationalRect l t w h
  where
    h             = 4/5
    w             = 2/5
    t             = (1-h)/2
    l             = (1-w)/2
manageCenter      = customFloating $ W.RationalRect l t w h
  where
    h             = 0.9
    w             = 0.9
    t             = 0.95 -h
    l             = 0.95 -w
manageCenterSml   = customFloating $ W.RationalRect l t w h
  where
    h             = 0.7
    w             = 0.7
    t             = 0.85 -h
    l             = 0.85 -w

mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Defining a bunch of layouts, many that I don't use.
tall     = renamed [Replace "tall"]
           $ limitWindows 12
           $ mySpacing 8
           $ ResizableTall 1 (3/100) (1/2) []
magnify  = renamed [Replace "magnify"]
           $ magnifier
           $ limitWindows 12
           $ mySpacing 8
           $ ResizableTall 1 (3/100) (1/2) []
monocle  = renamed [Replace "monocle"]
           $ limitWindows 20 Full
floats   = renamed [Replace "floats"]
           $ limitWindows 20 simplestFloat
grid     = renamed [Replace "grid"]
           $ limitWindows 12
           $ mySpacing 8
           $ mkToggle (single MIRROR)
           $ Grid (16/10)
spirals  = renamed [Replace "spirals"]
           $ mySpacing' 8
           $ spiral (6/7)
threeCol = renamed [Replace "threeCol"]
           $ limitWindows 7
           $ mySpacing' 4
           $ ThreeCol 1 (3/100) (1/2)
threeRow = renamed [Replace "threeRow"]
           $ limitWindows 7
           $ mySpacing' 4
           -- Mirror takes a layout and rotates it by 90 degrees.
           -- So we are applying Mirror to the ThreeCol layout.
           $ Mirror
           $ ThreeCol 1 (3/100) (1/2)

-- The layout hook
myLayoutHook                   = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats $
               mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where
               -- I've commented out the layouts I don't use.
               myDefaultLayout =     tall
                                 ||| magnify
                                 ||| noBorders monocle
                                 -- ||| floats
                                 -- ||| grid
                                 -- ||| noBorders tabs
                                 ||| spirals
                                 -- ||| threeCol
                                 -- ||| threeRow

xmobarEscape :: String -> String
xmobarEscape          = concatMap doubleLts
  where
        doubleLts '<' = "<<"
        doubleLts x   = [x]

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll [] <+> namedScratchpadManageHook myScratchPads

myLogHook :: X ()
myLogHook            = fadeInactiveLogHook fadeAmount
    where fadeAmount = 1.0

myKeys :: [(String, X ())]
myKeys =
        [ ("M-<Return>", spawn myTerminal)
        , ("M-q", spawn "xmonad --recompile && xmonad --restart")
        , ("M-r", shellPrompt dtXPConfig)   -- Shell Prompt

    -- Windows
        , ("M-<Backspace>", kill1)                           -- Kill the currently focused client
        , ("M-S-a", killAll)                         -- Kill all windows on current workspace

    -- Windows navigation
        -- , ("M-m", windows W.focusMaster)     -- Move focus to the master window
        , ("M-j", windows W.focusDown)       -- Move focus to the next window
        , ("M-k", windows W.focusUp)         -- Move focus to the prev window
        --, ("M-S-m", windows W.swapMaster)    -- Swap the focused window and the master window
        , ("M-S-j", windows W.swapDown)      -- Swap focused window with next window
        , ("M-S-k", windows W.swapUp)        -- Swap focused window with prev window
        , ("M-p", promote)         -- Moves focused window to master, others maintain order
        --, ("M-S-s", windows copyToAll)
        -- , ("M-C-s", killAllOtherCopies)

        -- Layouts
        , ("M-;", sendMessage NextLayout)                -- Switch to next layout
        , ("M-C-M1-<Up>", sendMessage Arrange)
        , ("M-C-M1-<Down>", sendMessage DeArrange)
        , ("M-<Space>", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggles noborder/full
        , ("M-S-<Space>", sendMessage ToggleStruts)         -- Toggles struts
        , ("M-S-n", sendMessage $ MT.Toggle NOBORDERS)      -- Toggles noborder
        , ("M-<KP_Multiply>", sendMessage (IncMasterN 1))   -- Increase number of clients in master pane
        , ("M-<KP_Divide>", sendMessage (IncMasterN (-1)))  -- Decrease number of clients in master pane
        , ("M-S-<KP_Multiply>", increaseLimit)              -- Increase number of windows
        , ("M-S-<KP_Divide>", decreaseLimit)                -- Decrease number of windows

        , ("M-h", sendMessage Shrink)                       -- Shrink horiz window width
        , ("M-l", sendMessage Expand)                       -- Expand horiz window width
        , ("M-C-j", sendMessage MirrorShrink)               -- Shrink vert window width
        , ("M-C-k", sendMessage MirrorExpand)               -- Exoand vert window width

    -- Workspaces
        , ("M-f", nextScreen)  -- Switch focus to next monitor
        , ("M-S-f", shiftNextScreen)  -- Switch focus to next monitor

    -- ScratchpadS
        , ("M-n", namedScratchpadAction myScratchPads "signal")
        , ("M-m", namedScratchpadAction myScratchPads "term")
        , ("M-g", namedScratchpadAction myScratchPads "browser")
        , ("M-p", namedScratchpadAction myScratchPads "pavu")
        -- , ("M-e", namedScratchpadAction myScratchPads "emacsclient")
        , ("M-d", namedScratchpadAction myScratchPads "discord")
        , ("M-i", namedScratchpadAction myScratchPads "neopad")
        , ("M-o", namedScratchpadAction myScratchPads "ranger")
        , ("M-C-b", scratchpads)

    -- Emacs (CTRL-e followed by a key)
        , ("C-e e", spawn "emacsclient -c -a ''")                            -- start emacs
        , ("C-e b", spawn "emacsclient -c -a '' --eval '(ibuffer)'")         -- list emacs buffers
        , ("C-e d", spawn "emacsclient -c -a '' --eval '(dired nil)'")       -- dired emacs file manager
        --, ("C-e i", spawn "emacsclient -c -a '' --eval '(erc)'")             -- erc emacs irc client
        --, ("C-e m", spawn "emacsclient -c -a '' --eval '(mu4e)'")            -- mu4e emacs email client
        --, ("C-e n", spawn "emacsclient -c -a '' --eval '(elfeed)'")          -- elfeed emacs rss client
        , ("C-e s", spawn "emacsclient -c -a '' --eval '(eshell)'")          -- eshell within emacs
        --, ("C-e t", spawn "emacsclient -c -a '' --eval '(mastodon)'")        -- mastodon within emacs
        --, ("C-e v", spawn "emacsclient -c -a '' --eval '(+vterm/here nil)'") -- vterm within emacs
        -- emms is an emacs audio player. I set it to auto start playing in a specific directory.
        --, ("C-e a", spawn "emacsclient -c -a '' --eval '(emms)' --eval '(emms-play-directory-tree \"~/Music/Non-Classical/70s-80s/\")'")

    --- Apps
        , ("M-/", spawn "qutebrowser")
        , ("M-<Print>", spawn "~/.scripts/scrotmenu.sh")
        , ("<Print>", spawn "sleep 0.1 && ~/.scripts/scrt-select")
        , ("<XF86AudioMute>",   spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
        , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -14%")
        , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +14%")
        ]
        -- The following lines are needed for named scratchpads.
          where nonNSP         = WSIs (return (\ws -> W.tag ws /= "nsp"))
                nonEmptyNonNSP = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "nsp"))
                scratchpads    = do {namedScratchpadAction myScratchPads "barpad1" ;
                                     namedScratchpadAction myScratchPads "barpad2" ;
                                     namedScratchpadAction myScratchPads "barpad3" }



myWorkspaces :: [String]
myWorkspaces = withScreens 2 ["one", "two", "three", "four", "five"]

-- workspaceKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
--     [((m .|. modm, k), windows $ onCurrentScreen f i)
--         | (i, k) <- zip (workspaces' conf) [xK_z,xK_x,xK_c,xK_v,xK_b]
--         , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

workspaceKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [((0 .|. modm, k), do {windows $ onCurrentScreen W.greedyView i; nextScreen; windows $ onCurrentScreen W.greedyView i; nextScreen})
        | (i, k) <- zip (workspaces' conf) [xK_z,xK_x,xK_c,xK_v,xK_b]]
    ++
    [((shiftMask .|. modm, k), windows $ onCurrentScreen W.shift i)
        | (i, k) <- zip (workspaces' conf) [xK_z,xK_x,xK_c,xK_v,xK_b]]
    
main :: IO ()
main                         = do
    xmonad $ ewmh def
        { manageHook         = ( isFullscreen --> doFullFloat ) <+> myManageHook <+> manageDocks
        -- Run xmonad commands from command line with "xmonadctl command". Commands include:
        -- shrink, expand, next-layout, default-layout, restart-wm, xterm, kill, refresh, run,
        -- focus-up, focus-down, swap-up, swap-down, swap-master, sink, quit-wm. You can run
        -- "xmonadctl 0" to generate full list of commands written to ~/.xsession-errors.
        , handleEventHook    = serverModeEventHookCmd
                               <+> serverModeEventHook
                               <+> serverModeEventHookF "XMONAD_PRINT" (io . putStrLn)
        , modMask            = myModMask
        , terminal           = myTerminal
        , startupHook        = myStartupHook
        , layoutHook         = myLayoutHook
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormColor
        , focusedBorderColor = myFocusColor
        , keys               = workspaceKeys
        , logHook            = workspaceHistoryHook <+> myLogHook <+> dynamicLogWithPP xmobarPP
                        {
                          ppCurrent         = xmobarColor "#c3e88d" "" . wrap "[" "]" -- Current workspace in xmobar
                        , ppVisible         = xmobarColor "#c3e88d" ""                -- Visible but not current workspace
                        , ppHidden          = xmobarColor "#82AAFF" "" . wrap "*" ""   -- Hidden workspaces in xmobar
                        , ppHiddenNoWindows = xmobarColor "#c792ea" ""        -- Hidden workspaces (no windows)
                        , ppTitle           = xmobarColor "#b3afc2" "" . shorten 60     -- Title of active window in xmobar
                        , ppSep             =  "<fc=#666666> <fn=2>|</fn> </fc>"                     -- Separators in xmobar
                        , ppUrgent          = xmobarColor "#C45500" "" . wrap "!" "!"  -- Urgent workspace
                        , ppExtras          = [windowCount]                           -- # of windows current workspace
                        , ppOrder           = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                        }
        } `additionalKeysP` myKeys
