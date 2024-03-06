#!/usr/bin/env bash
hyprlock &
hypridle&
swww init &
sleep 0.1 &&
swww img ~/.dotfiles/wallpaper/fix.png &
swaync

