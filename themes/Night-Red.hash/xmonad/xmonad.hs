-- xmonad config used by Malcolm MD
-- https://github.com/randomthought/xmonad-config
--

import System.IO
import System.Exit
--import System.Taffybar.Hooks.PagerHints (pagerHints)

import qualified Data.List as L

import XMonad
import XMonad.Actions.Navigation2D
--import XMonad.Actions.UpdatePointer

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops (ewmh)

import XMonad.Layout.Gaps
import XMonad.Layout.Fullscreen
import XMonad.Layout.BinarySpacePartition as BSP
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Spacing
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.Renamed
import XMonad.Layout.Simplest
import XMonad.Layout.SubLayouts
--import XMonad.Layout.WindowNavigation
import XMonad.Layout.ZoomRow

import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Cursor

import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.Actions.CopyWindow
----------------------------mupdf--------------------------------------------
-- Terminimport XMonad.Hooks.EwmhDesktopsal
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal = "termite"

-- The command to take a selective screenshot.
myScreenshot = "h-screenshot"

-- The command to use as a launcher, to launch commands that don't have
-- preset keybindings.
myLauncher = "rofi -modi drun -show drun"



------------------------------------------------------------------------
-- Workspaces
-- The default number of workspaces (virtual screens) and their names.
--
ws1 = " \xf0da \xf120 "
ws2 = " \xf0da \xf0ac "
ws3 = " \xf0da \xf086 "
ws4 = " \xf0da \xf07c "
ws5 = " \xf0da \xf121 "
ws6 = " \xf0da \xf53f "
ws7 = " \xf0da \xf674 "
ws8 = " \xf0da \xf108 "
ws9 = " \xf0da \xf58f "

--myWorkspaces = [" 1: \xf120"," 2: web "," 3: chat "," 4: files "] ++ map show [5..9]
xmobarEscape = concatMap doubleLts
  where doubleLts '<' = "<<"
        doubleLts x   = [x]

myWorkspaces :: [String]        
myWorkspaces = fontawesome . (map xmobarEscape) $ [ ws1,ws2,ws3,ws4,ws5,ws6,ws7,ws8,ws9]
    where                                                                      
      fontawesome l = [ "<action=xdotool key super+" ++ show (n) ++ "><fn=5>" ++ ws ++ "</fn></action>" |
                      (i,ws) <- zip [1..9] l, let n = i ]


------------------------------------------------------------------------
-- Window rules
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
-- Move favorites app to workspaces
myManageHook :: ManageHook
myManageHook = composeAll . concat $
    [ [ resource  =? r -->  doIgnore  | r <- myIgnores  ]
    , [ className =? c --> doCenterFloat | c <- myFloats ]
    , [ title =? t --> doCenterFloat | t <- myFloatstitle]
    , [ className =? c --> doShift (myWorkspaces !! 1) | c <- myWebApps ]
    , [ className =? c --> doShift (myWorkspaces !! 2) | c <- myChatApps ]
    , [ className =? c --> doShift (myWorkspaces !! 3) | c <- myFileApps ]
    , [ className =? c --> doShift (myWorkspaces !! 4) | c <- myEditorApps ]
    , [ className =? c --> doShift (myWorkspaces !! 5) | c <- myPaintApps ]
    , [ className =? c --> doShift (myWorkspaces !! 7) | c <- myVMApps ]
    , [ isFullscreen   --> doFullFloat ]
    , [ isDialog     -->  doCenterFloat       ] ]
    where
        myIgnores = ["desktop","desktop_window","screenkey"]
        myWebApps = ["my-browser-class","my-other-browser"]
        myFileApps = ["my-file-class"] 
        myChatApps = ["my-chat-class"] 
        myEditorApps = ["my-editor-class", "my-other-editor-class"]
        myPaintApps = ["my-paint-app"] 
        myVMApps = ["my-vm-class"] 
        myFloats = ["Variety", "yad", "Yad"]
        myFloatstitle = ["Picture in picture"]

-----------------------------------------------------------------------
-- Layouts
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-ctrl-r') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.

outerGaps    = 2
innerGaps    = 2
addSpace = spacingRaw True             -- Only for >1 window
                       -- The bottom edge seems to look narrower than it is
                       (Border outerGaps outerGaps outerGaps outerGaps) -- Outer gaps
                       True             -- Enable screen edge gaps
                       (Border innerGaps innerGaps innerGaps innerGaps) -- Inner gaps
                       True             -- Enable window gaps

tab          =  avoidStruts
               $ renamed [Replace "Tabbed"]
               $ addTopBar
               $ tabbed shrinkText myTabTheme

layouts      = avoidStruts (
                (
                    renamed [CutWordsLeft 1]
                  $ addTopBar
                  $ renamed [Replace "BSP"]
                  $ addTabs shrinkText myTabTheme
                  $ subLayout [] Simplest
                  $ addSpace (BSP.emptyBSP)
                )
                ||| tab
               )

myLayout    = smartBorders
              $ mkToggle (NOBORDERS ?? FULL ?? EOT)
              $ layouts

myNav2DConf = def
    { defaultTiledNavigation    = centerNavigation
    , floatNavigation           = centerNavigation
    , screenNavigation          = lineNavigation
    , layoutNavigation          = [("Full",          centerNavigation)
    -- line/center same results   ,("Tabs", lineNavigation)
    --                            ,("Tabs", centerNavigation)
                                  ]
    , unmappedWindowRect        = [("Full", singleWindowRect)
    -- works but breaks tab deco  ,("Tabs", singleWindowRect)
    -- doesn't work but deco ok   ,("Tabs", fullScreenRect)
                                  ]
    }


------------------------------------------------------------------------
-- Colors and borders

-- Color of current window title in xmobar.
xmobarTitleColor = red

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = red

-- Width of the window border in pixels.
myBorderWidth = 1

myNormalBorderColor     = "#313131"
myFocusedBorderColor    = red

base03  = "#f0f1fa"
base02  = "#0d0d0d"
base00  = "#b4b4b4"
yellow  = "#b58900"
orange  = "#cb4b16"
red     = "#ec0101"
magenta = "#d33682"
violet  = "#6c71c4"
blue    = "#5da0ee"
cyan    = "#5beedc"
green   = "#859900"

-- sizes
topbar      = 0
border      = 0
prompt      = 20
status      = 20

active      = "#000000"
activeWarn  = red
inactive    = "#0d0d0d"
focusColor  = blue
unfocusColor = base02

-- myFont      = "-*-Zekton-medium-*-*-*-*-160-*-*-*-*-*-*"
-- myBigFont   = "-*-Zekton-medium-*-*-*-*-240-*-*-*-*-*-*"
myFont      = "xft:Zekton:size=9:bold:antialias=true"
myBigFont   = "xft:Zekton:size=9:bold:antialias=true"
myWideFont  = "xft:Eurostar Black Extended:"
            ++ "style=Regular:pixelsize=180:hinting=true"

-- this is a "fake title" used as a highlight bar in lieu of full borders
-- (I find this a cleaner and less visually intrusive solution)
topBarTheme = def
    {
      fontName              = myFont
    , inactiveBorderColor   = inactive
    , inactiveColor         = inactive
    , inactiveTextColor     = "#595959"
    , activeBorderColor     = active
    , activeColor           = active
    , activeTextColor       = red
    , urgentBorderColor     = red
    , urgentTextColor       = yellow
    , decoHeight            = topbar
    }

addTopBar =  noFrillsDeco shrinkText topBarTheme

myTabTheme = def
    { fontName              = myFont
    , activeColor           = active
    , inactiveColor         = inactive
    , activeBorderColor     = active
    , inactiveBorderColor   = inactive
    , activeTextColor       = red
    , inactiveTextColor     = "#595959"
    }

------------------------------------------------------------------------
-- Key bindings
--
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask = mod4Mask
altMask = mod1Mask

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  ----------------------------------------------------------------------
  -- Custom key bindings
  --



  -- Start a terminal.  Terminal to start is specified by myTerminal variable.
  [ ((modMask, xK_Return),
     spawn $ XMonad.terminal conf)


  , ((modMask,                 xK_z    ), windows copyToAll) -- %! Sticky window
  , ((modMask .|. shiftMask,   xK_z    ), killAllOtherCopies) -- %! Not sticky



  -- Lock the screen using command specified by myScreensaver.
  --, ((modMask, xK_0),
  --   spawn myScreensaver)

  -- Spawn the launcher using command specified by myLauncher.
  -- Use this to launch programs without a key binding.
  , ((modMask, xK_d),
     spawn myLauncher)

  -- Take a selective screenshot.
  , ((0, xK_Print),
     spawn myScreenshot)

   -- Toggle current focus window to fullscreen
  , ((modMask, xK_f), sendMessage $ Toggle FULL)

  , ((modMask, xK_x),
     spawn "power-menu")

  , ((mod1Mask .|. controlMask, xK_l),
     spawn "betterlockscreen -l dim")

  -- Mute volume.
  , ((0, xF86XK_AudioMute),
     spawn "amixer -q set Master toggle;amixer get Master | awk -F'[]%[]' '/%/ { print $5 }' | head -n 1 >> /tmp/volume")

  -- Decrease volume.
  , ((0, xF86XK_AudioLowerVolume),
     spawn "amixer -q set Master 5%-;amixer get Master | awk -F'[]%[]' '/%/ { print $2 }' | head -n 1 >> /tmp/volume")

  -- Increase volume.
  , ((0, xF86XK_AudioRaiseVolume),
     spawn "amixer -q set Master 5%+;amixer get Master | awk -F'[]%[]' '/%/ { print $2 }' | head -n 1 >> /tmp/volume")
  -- Audio previous.
  , ((0, 0x1008FF16),
     spawn "")

  -- Play/pause.
  , ((0, 0x1008FF14),
     spawn "")

  -- Audio next.
  , ((0, 0x1008FF17),
     spawn "")

  -- Eject CD tray.
  , ((0, 0x1008FF2C),
     spawn "eject -T")

  --------------------------------------------------------------------
  -- "Standard" xmonad key bindings
  --

  -- Close focused window.
  , ((modMask, xK_q),
     kill)

  -- Cycle through the available layout algorithms.
  , ((modMask, xK_space),
     sendMessage NextLayout)

  --  Reset the layouts on the current workspace to default.
  , ((modMask .|. shiftMask, xK_space),
     setLayout $ XMonad.layoutHook conf)

  -- Resize viewed windows to the correct size.
  , ((modMask, xK_n),
     refresh)

  -- Move focus to the next window.
  , ((modMask, xK_j),
     windows W.focusDown)

  -- Move focus to the previous window.
  , ((modMask, xK_k),
     windows W.focusUp  )

  -- Move focus to the master window.
  , ((modMask, xK_m),
     windows W.focusMaster  )

  -- Swap the focused window and the master window.
  , ((modMask .|. shiftMask, xK_Return),
     windows W.swapMaster)

  -- Swap the focused window with the next window.
  , ((modMask .|. shiftMask, xK_j),
     windows W.swapDown  )

  -- Swap the focused window with the previous window.
  , ((modMask .|. shiftMask, xK_k),
     windows W.swapUp    )

  -- Shrink the master area.
  , ((modMask, xK_h),
     sendMessage Shrink)

  -- Expand the master area.
  , ((modMask, xK_l),
     sendMessage Expand)

  -- Push window back into tiling.
  , ((modMask, xK_t),
     withFocused $ windows . W.sink)

  -- Increment the number of windows in the master area.
  , ((modMask, xK_comma),
     sendMessage (IncMasterN 1))

  -- Decrement the number of windows in the master area.
  , ((modMask, xK_period),
     sendMessage (IncMasterN (-1)))

  -- Quit xmonad.
  , ((modMask .|. shiftMask, xK_x),
     io (exitWith ExitSuccess))

  -- Restart xmonad.
  , ((modMask .|. controlMask, xK_r),
     restart "xmonad" True)
  ]
  ++

  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  [((m .|. modMask, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
  ++

  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
  [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


  ++
  -- Bindings for manage sub tabs in layouts please checkout the link below for reference
  -- https://hackage.haskell.org/package/xmonad-contrib-0.13/docs/XMonad-Layout-SubLayouts.html
  [
    -- Tab current focused window with the window to the left
    ((modMask .|. controlMask, xK_h), sendMessage $ pullGroup L)
    -- Tab current focused window with the window to the right
  , ((modMask .|. controlMask, xK_l), sendMessage $ pullGroup R)
    -- Tab current focused window with the window above
  , ((modMask .|. controlMask, xK_k), sendMessage $ pullGroup U)
    -- Tab current focused window with the window below
  , ((modMask .|. controlMask, xK_j), sendMessage $ pullGroup D)

  -- Tab all windows in the current workspace with current window as the focus
  , ((modMask .|. controlMask, xK_m), withFocused (sendMessage . MergeAll))
  -- Group the current tabbed windows
  , ((modMask .|. controlMask, xK_u), withFocused (sendMessage . UnMerge))

  -- Toggle through tabes from the right
  , ((modMask, xK_Tab), onGroup W.focusDown')
  ]

  ++
  -- Some bindings for BinarySpacePartition
  -- https://github.com/benweitzman/BinarySpacePartition
  [
    ((modMask .|. controlMask,               xK_Right ), sendMessage $ ExpandTowards R)
  , ((modMask .|. controlMask .|. shiftMask, xK_Right ), sendMessage $ ShrinkFrom R)
  , ((modMask .|. controlMask,               xK_Left  ), sendMessage $ ExpandTowards L)
  , ((modMask .|. controlMask .|. shiftMask, xK_Left  ), sendMessage $ ShrinkFrom L)
  , ((modMask .|. controlMask,               xK_Down  ), sendMessage $ ExpandTowards D)
  , ((modMask .|. controlMask .|. shiftMask, xK_Down  ), sendMessage $ ShrinkFrom D)
  , ((modMask .|. controlMask,               xK_Up    ), sendMessage $ ExpandTowards U)
  , ((modMask .|. controlMask .|. shiftMask, xK_Up    ), sendMessage $ ShrinkFrom U)
  , ((modMask,                               xK_r     ), sendMessage BSP.Rotate)
  , ((modMask,                               xK_s     ), sendMessage BSP.Swap)
  -- , ((modMask,                               xK_n     ), sendMessage BSP.FocusParent)
  -- , ((modMask .|. controlMask,               xK_n     ), sendMessage BSP.SelectNode)
  -- , ((modMask .|. shiftMask,                 xK_n     ), sendMessage BSP.MoveNode)
  ]

------------------------------------------------------------------------
-- Mouse bindings
--
-- Focus rules
-- True if your focus should follow your mouse cursor.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
  [
    -- mod-button1, Set the window to floating mode and move by dragging
    ((modMask, button1),
     (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2),
       (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3),
       (\w -> focus w >> mouseResizeWindow w))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
  ]


------------------------------------------------------------------------
-- Status bars and logging
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
-- To emulate dwm's status bar
--
-- > logHook = dynamicLogDzen
--


------------------------------------------------------------------------
-- Startup hook
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
  setWMName "xmonad"
  spawn     "pkill trayer ; trayer --edge top --align left --widthtype request --height 21 --alpha 0 --transparent true --monitor primary --width 3 --iconspacing 5 --tint 0x000000"
  spawn     "bash ~/.xmonad/startup.sh"
  setDefaultCursor xC_left_ptr



------------------------------------------------------------------------
-- Run xmonad with all the defaults we set up.
--
main = do
  xmproc <- spawnPipe "xmobar ~/.xmonad/xmobarrc.hs"
  -- xmproc <- spawnPipe "taffybar"
  xmonad $ docks
         $ withNavigation2DConfig myNav2DConf
         $ additionalNav2DKeys (xK_Up, xK_Left, xK_Down, xK_Right)
                               [
                                  (mod4Mask,               windowGo  )
                                , (mod4Mask .|. shiftMask, windowSwap)
                               ]
                               False
         $ ewmh
         -- $ pagerHints -- uncomment to use taffybar
         $ defaults {
         logHook = dynamicLogWithPP xmobarPP {
                 ppCurrent = xmobarColor base03 xmobarCurrentWorkspaceColor . wrap "" "" 
                        
                , ppTitle = xmobarColor xmobarTitleColor "" . shorten 20
                , ppSep = "   "
                , ppOrder  = \(ws:l:t:ex) -> [t,l,ws]
                , ppOutput = hPutStrLn xmproc
         }-- >> updatePointer (0.75, 0.75) (0.75, 0.75)
      }

------------------------------------------------------------------------
-- Combine it all together
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
    -- simple stuff
    terminal           = myTerminal,
    focusFollowsMouse  = myFocusFollowsMouse,
    borderWidth        = myBorderWidth,
    modMask            = myModMask,
    workspaces         = myWorkspaces,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,

    -- key bindings
    keys               = myKeys,
    mouseBindings      = myMouseBindings,

    -- hooks, layouts
    layoutHook         = myLayout,
    -- handleEventHook    = E.fullscreenEventHook,
    handleEventHook    = fullscreenEventHook,
    manageHook         = manageDocks <+> myManageHook,
    startupHook        = myStartupHook
}
