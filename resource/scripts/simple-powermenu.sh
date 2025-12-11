#!/bin/bash

# Show a simple power menu with Dracula lock
action=$(printf "Lock\nSuspend\nLogout\nReboot\nPoweroff" | rofi -dmenu -p "Power Menu")

# Detect if we are on Sway or Hyprland
WM=$(echo "$XDG_CURRENT_DESKTOP $DESKTOP_SESSION $XDG_SESSION_DESKTOP $WAYLAND_DISPLAY" | tr '[:upper:]' '[:lower:]')

case "$action" in
Lock)
    if [[ $WM == *hyprland* ]]; then
        swaylock -c 282a36
    else
        swaylock -c 282a36
    fi
    ;;

Suspend)
    if [[ $WM == *hyprland* ]]; then
        swaylock --daemonize -c 282a36 && systemctl suspend
    else
        # swaylock --daemonize -c 282a36 && systemctl suspend
        swaylock --daemonize -i ~/Pictures/Arch.jpg && systemctl suspend
    fi
    ;;

Logout)
    if [[ $WM == *hyprland* ]]; then
        hyprctl dispatch exit
    else
        swaymsg exit
    fi
    ;;

Reboot)
    systemctl reboot
    ;;

Poweroff)
    systemctl poweroff
    ;;
esac
# #!/bin/bash
#
# # Show a simple power menu with Dracula lock
# action=$(printf "Lock\nSuspend\nLogout\nReboot\nPoweroff" | rofi -dmenu -p "Power Menu")
#
# case "$action" in
# Lock)
#     swaylock -c 282a36
#     ;;
#
# Suspend)
#     swaylock --daemonize -c 282a36 && systemctl suspend
#     ;;
#
# Logout)
#     swaymsg exit
#     ;;
#
# Reboot)
#     systemctl reboot
#     ;;
#
# Poweroff)
#     systemctl poweroff
#     ;;
# esac
# #!/bin/bash
#
# # Show a simple power menu with Dracula lock
# action=$(printf "Lock\nSuspend\nLogout\nReboot\nPoweroff" | rofi -dmenu -p "Power Menu")
#
# # Detect if we are on Sway or Hyprland
# WM=$(echo "$XDG_CURRENT_DESKTOP $DESKTOP_SESSION $XDG_SESSION_DESKTOP $WAYLAND_DISPLAY" | tr '[:upper:]' '[:lower:]')
#
# case "$action" in
# Lock)
#     if [[ $WM == *hyprland* ]]; then
#         swaylock -c 282a36
#     else
#         swaylock -c 282a36
#     fi
#     ;;
#
# Suspend)
#     if [[ $WM == *hyprland* ]]; then
#         swaylock --daemonize -c 282a36 && systemctl suspend
#     else
#         swaylock --daemonize -c 282a36 && systemctl suspend
#     fi
#     ;;
#
# Logout)
#     if [[ $WM == *hyprland* ]]; then
#         hyprctl dispatch exit
#     else
#         swaymsg exit
#     fi
#     ;;
#
# Reboot)
#     systemctl reboot
#     ;;
#
# Poweroff)
#     systemctl poweroff
#     ;;
# esac
