#!/bin/zsh
compton --backend glx --paint-on-overlay --glx-no-stencil --vsync opengl-swc --unredir-if-possible &
export QT_QPA_PLATFORMTHEME="qt5ct"
# Log stderror to a file

count=0
while dwm 2> ~/.dwm.log ; [ $? -eq 2 ]
do
	let count+=1
	~/script/notify-send.sh --replace-file=/tmp/dwm-restart-notification "dwm restarted" "dwm has been restarted $count times" &
done
killall compton
