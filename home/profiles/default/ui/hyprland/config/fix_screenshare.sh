#!/usr/bin/env bash

systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
/run/current-system/sw/bin/dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

sleep 1
pkill -e xdg-desktop-portal-hyprland
pkill -e xdg-desktop-portal-wlr
pkill xdg-desktop-portal
/etc/systemd/user/xdg-desktop-portal-hyprland.service &
sleep 2
/etc/systemd/user/xdg-desktop-portal.service &
