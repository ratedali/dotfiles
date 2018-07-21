import           XMonad
import           XMonad.Util.EZConfig
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           Graphics.X11.ExtraTypes.XF86
import           XMonad.Util.Run (spawnPipe)
import           System.IO
import qualified XMonad.StackSet as W
import qualified Data.Map as M

myTerminal = "env TERMCMD=urxvtc ~/.bin/tmux_attach"
myBorderWidth = 0
myModMask = mod4Mask
myWorkspaces = ["web", "files", "code", "admin", "games", "chat", "video", "music", "downloads"]

-- Key Bindings
keyUnbindings = [
    (myModMask, xK_space)]

keyBindings = [
    -- launch a terminal
    ((myModMask, xK_Return), spawn "urxvtc -title Terminal -e ~/.bin/tmux_term")
    -- application menu
    , ((mod1Mask, xK_F1), spawn "j4-dmenu-desktop --dmenu 'rofi -dmenu -i' --term 'urxvtc'")
    -- run commands
    , ((mod1Mask, xK_F2), spawn "rofi -show run")
    -- web browser
    , ((myModMask, xK_c), spawn "dex /usr/share/applications/firefox.desktop")
    -- file manager
    , ((myModMask, xK_e), spawn "env TERMCMD=urxvtc ~/.bin/file_manager.sh")
    -- editor
    , ((myModMask, xK_v), spawn "env TERMCMD=urxvtc EDITOR=nvim ~/.bin/editor.sh")
    -- video player
    , ((myModMask, xK_s), spawn "dex /usr/share/applications/smplayer.desktop")
    -- music player
    , ((myModMask, xK_m), spawn "env TERMCMD=urxvtc ~/.bin/music.sh")
    -- brightness
    , ((0, xF86XK_MonBrightnessUp), spawn "xbacklight +2%")
    , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -2%")
    -- volume
    , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 2%- unmute")
    , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 2%+ unmute")
    , ((0, xF86XK_AudioMute), spawn "amixer set Master toggle")
    -- toggle fullscreen
    , ((myModMask .|. shiftMask, xK_f), sendMessage ToggleStruts)]

-- Manage Hooks
myManageHooks = composeAll
    [ isFullscreen        --> doFullFloat]

main = do
    xmproc <- spawnPipe "xmobar ~/.xmobarrc"
    xmonad $ def
        { modMask           = myModMask
        , terminal          = myTerminal
        , borderWidth       = myBorderWidth
        , workspaces        = myWorkspaces
        -- key bindings
        -- , keys              = myKeyBindings <+> keys def
        -- hooks and layouts
        , manageHook        = manageDocks <+> myManageHooks <+> manageHook def
        , layoutHook        = avoidStruts $ layoutHook def
        , handleEventHook   = handleEventHook def <+> docksEventHook
        , logHook           = dynamicLogWithPP xmobarPP
                            { ppOutput          = hPutStrLn xmproc
                            , ppTitle           = xmobarColor "darkgreen" "" . shorten 50
                            }
        , startupHook       = do
                                spawn "dex -e xmonad -a ~/.config/autostart"
                                spawn "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --transparent true --tint 0x000000 --height 28"
                                spawn "nitrogen --restore"
                                spawn "compton -b --backend glx --vsync opengl -cCGf"
        } `removeKeys` keyUnbindings `additionalKeys` keyBindings
