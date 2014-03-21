import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import System.IO

main = do
	xmproc <- spawnPipe "/usr/local/bin/xmobar ~/.xmobarrc"
	xmonad $ defaultConfig
