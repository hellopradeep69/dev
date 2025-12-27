#!/usr/bin/env bash
# Install i3wm

Install_i3() {
    # sudo pacman -Syu
    if command -v pacman >/dev/null 2>&1;then
        sudo pacman -S --noconfirm --needed i3-wm i3lock i3status dunst rofi xclip copyq picom
    else
        sudo xbps-install -Sy rofi
    fi
}

Make_dir() {
    trash $HOME/.config/i3status/ $HOME/.config/i3/ $HOME/.config/picom/
    mkdir -p $HOME/.config/i3status/
    mkdir -p $HOME/.config/i3/
    mkdir -p $HOME/.config/picom/
}

Copy_it() {
    cp -r $HOME/dev/resource/i3/. $HOME/.config/i3
    cp -r $HOME/dev/resource/i3status/. $HOME/.config/i3status
    cp -r $HOME/dev/resource/picom/. $HOME/.config/picom
}

Main() {
    echo "installing i3wm"
    echo "Rofi doesnt need any like config"
    Install_i3
    Make_dir
    Copy_it
    echo " "
    echo "reloading"
    sleep 2
    echo "done"
}

Main
