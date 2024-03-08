#!/usr/bin/env bash

systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
/run/current-system/sw/bin/dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

sleep 1
pkill -e xdg-desktop-portal-hyprland
pkill -e xdg-desktop-portal-wlr
pkill xdg-desktop-portal
/usr/lib/xdg-desktop-portal-hyprland &
sleep 2
/usr/lib/xdg-desktop-portal &
