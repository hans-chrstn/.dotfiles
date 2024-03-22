#!/usr/bin/env bash
hyprlock &
hypridle&
hyprpaper&
#ags -c ~/.dotfiles/home/profiles/default/ui/ags/config/config.js &
sleep 5 &
eww daemon &
sleep 15 &
eww open bar &
wl-gammarelay-rs

