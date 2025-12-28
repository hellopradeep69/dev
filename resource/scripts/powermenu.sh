#!/bin/bash

action=$(printf "Lock\nSuspend\nLogout\nReboot\nPoweroff" | rofi -dmenu -p "Power Menu")

# Detect session / WM
SESSION=$(echo "$XDG_CURRENT_DESKTOP $DESKTOP_SESSION $XDG_SESSION_TYPE $WAYLAND_DISPLAY" | tr '[:upper:]' '[:lower:]')

lock() {
    if [[ "$SESSION" == *x11* ]] || [[ -z "$WAYLAND_DISPLAY" ]]; then
        # i3 / X11
        i3lock -i ~/Downloads/Arch.png
    else
        # Wayland (Sway / Hyprland)
        swaylock -c 282a36
    fi
}

logout() {
    if [[ "$SESSION" == *hyprland* ]]; then
        hyprctl dispatch exit
    elif [[ "$SESSION" == *sway* ]]; then
        swaymsg exit
    else
        i3-msg exit
    fi
}

suspend() {
    if [[ "$SESSION" == *x11* ]] || [[ -z "$WAYLAND_DISPLAY" ]]; then
        i3lock -i ~/Downloads/Arch.png && systemctl suspend
    else
        swaylock --daemonize -c 282a36 && systemctl suspend
    fi
}

case "$action" in
    Lock)
        lock
        ;;
    Suspend)
        suspend
        ;;
    Logout)
        logout
        ;;
    Reboot)
        systemctl reboot
        ;;
    Poweroff)
        systemctl poweroff
        ;;
esac
