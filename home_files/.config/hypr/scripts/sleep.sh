#!/bin/bash

case "$1" in
  pause)
    dunstctl set-paused true
    canberra-gtk-play -i audio-volume-change -d "changevolume"
    hyprctl notify 1 1000 "rgb(c6a0f6)" "Dunst paused!"
    ;;
  resume)
    dunstctl set-paused false
    canberra-gtk-play -i audio-volume-change -d "changevolume"
    hyprctl notify -1 1000 "rgb(c6a0f6)" "Dunst resumed!"     
    ;;
  *)
    echo "Usage: $0 {pause|resume}"
    exit 1
    ;;
esac

