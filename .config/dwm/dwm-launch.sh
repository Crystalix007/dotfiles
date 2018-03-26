#!/bin/zsh
# Log stderror to a file
compton --backend glx --paint-on-overlay --glx-no-stencil --vsync opengl-swc --unredir-if-possible &
export QT_QPA_PLATFORMTHEME="qt5ct"
dwm 2> ~/.dwm.log
killall compton
