#!/usr/bin/env bash
sleep 1 &
#hyprlock -c ~/.dotfiles/home/common/programs/hyprland/config/hyprlock.conf &
hypridle -c ~/.dotfiles/home/common/programs/hyprland/config/hypridle.conf &
hyprpaper -c ~/.dotfiles/home/common/programs/hyprland/config/hyprpaper.conf &
ags -c ~/.dotfiles/home/common/programs/ags/ags/config.js &
wl-gammarelay-rs

