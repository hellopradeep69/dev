#!/usr/bin/env bash
# Install i3wm

Install_i3() {
    # sudo pacman -Syu
    sudo pacman -S --noconfirm --needed i3-wm i3lock i3status dunst rofi xclip copyq
}

Make_dir() {
    trash $HOME/.config/i3status/ $HOME/.config/i3/
    mkdir -p $HOME/.config/i3status/
    mkdir -p $HOME/.config/i3/
}

Copy_it() {
    cp -r $HOME/dev/resource/i3/. $HOME/.config/i3
    cp -r $HOME/dev/resource/i3status/. $HOME/.config/i3status
}

Main() {
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
