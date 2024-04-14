#!/usr/bin/env bash
sleep 1 &
hyprlock -c ~/.dotfiles/home/profiles/default/ui/hyprland/config/hyprlock.conf &
hypridle -c ~/.dotfiles/home/profiles/default/ui/hyprland/config/hypridle.conf &
hyprpaper -c ~/.dotfiles/home/profiles/default/ui/hyprland/config/hyprpaper.conf &
ags -c ~/.dotfiles/home/profiles/default/ui/ags/ags/config.js &
wl-gammarelay-rs

