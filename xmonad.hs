import XMonad  
import XMonad.Hooks.DynamicLog  
import XMonad.Hooks.ManageDocks  
import XMonad.Util.Run  
import System.IO  
import XMonad.ManageHook
import XMonad.Layout.NoBorders  
import XMonad.Layout.PerWorkspace    

-- Define amount and names of workspaces  
myWorkspaces = ["1:web","2:email","3:terminal","4:media","5","6","7","8","9:junk"]

--Define which app goes where
myManageHook = composeAll
	[ className =? "Google-chrome" --> doShift "1:web"
	, className =? "Thunderbird" --> doShift "2:email"
	, className =? "mplayer" --> doShift "4:media"
	, className =? "Gimp" --> doFloat
	, className =? "Firefox" --> doShift "1:web"
	, manageDocks
	]

main = do  
xmproc <- spawnPipe "/usr/bin/xmobar"   
xmonad $ defaultConfig   
     { manageHook = myManageHook <+> manageHook defaultConfig  
     , layoutHook = avoidStruts $ layoutHook defaultConfig
     , workspaces = myWorkspaces
     , logHook = dynamicLogWithPP xmobarPP  
          { ppOutput = hPutStrLn xmproc  
          , ppTitle = xmobarColor "blue" "" . shorten 50   
          , ppLayout = const "" -- to disable the layout info on xmobar  
          }   
     }


