#!/usr/bin/env bash
# Install i3wm

Install_i3() {
    # sudo pacman -Syu
    if command -v pacman >/dev/null 2>&1;then
        sudo pacman -S --noconfirm --needed i3-wm i3lock i3status dunst rofi xclip \
            copyq picom brightnessctl lxappearance adapta-gtk-theme
    elif command -v dnf >/dev/null 2>&1;then
        sudo dnf install -y  i3 i3lock i3status dunst rofi xclip \
            copyq picom brightnessctl lxappearance
    else
        sudo xbps-install -Sy rofi i3 i3lock i3status dunst rofi xclip \
             picom brightnessctl lxappearance
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

Intel_status(){
    trash $HOME/.config/i3status/
    cp -r /home/hellopradeep/dev/resource/i3status-intel/. $HOME/.config/i3status
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

if [[ -f "/sys/class/power_supply/BAT0/capacity" ]]; then
    echo "Seems like you are having intel"
    Intel_status
    echo "intel setup"
fi

