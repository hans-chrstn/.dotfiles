#!/usr/bin/env bash
hyprlock &
hypridle&
hyprpaper&
#ags -c ~/.dotfiles/home/profiles/default/ui/ags/config/config.js &
eww daemon &
sleep 1 &
eww open bar &
wl-gammarelay-rs

