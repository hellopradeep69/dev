#!/usr/bin/env bash
# Install Sway | i3wm replacement

Install_sway() {
    # sudo pacman -Syu
    sudo pacman -S --noconfirm --needed sway swaylock i3status rofi-wayland brightnessctl mako slurp swaybg autotiling \
        wl-clipboard cliphist grim
}

Make_dir() {
    trash $HOME/.config/i3status/ $HOME/.config/sway/
    mkdir -p $HOME/.config/i3status/
    mkdir -p $HOME/.config/sway/
}

Copy_it() {
    cp -r $HOME/dev/resource/sway/. $HOME/.config/sway
    cp -r $HOME/dev/resource/i3status/. $HOME/.config/i3status
}

Intel_status(){
    trash $HOME/.config/i3status/
    cp -r /home/hellopradeep/dev/resource/i3status-intel/. $HOME/.config/i3status
}

Main() {
    echo "Rofi doesnt need any like config"
    Install_sway
    Make_dir
    Copy_it
    echo " "
    echo "reloading"
    sleep 2
    swaymsg reload
}

Main


if [[ -f "/sys/class/power_supply/BAT0/capacity" ]]; then
    echo "Seems like you are having intel"
    Intel_status
    echo "intel setup"
fi

