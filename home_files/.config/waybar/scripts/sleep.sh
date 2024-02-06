#!/usr/bin/env bash

pause() {
  dunstctl set-paused true
  hyprctl notify 1 1000 "rgb(c8a0f6)" "Dunst Paused!"
}

resume() {
  dunstctl set-paused false
  hyprctl notify -1 1000 "rgb(c6a0f6)" "Dunst Resumed"
}

case "$1" in
  pause)
    pause;;
  resume)
    resume;;
esac

