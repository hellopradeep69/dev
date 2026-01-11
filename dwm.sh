#!/usr/bin/env bash

Install_dwm(){
    echo "installing dwm and dependencies"
    if command -v pacman >/dev/null 2>&1;then
        sudo pacman -S --noconfirm --needed dwm dmenu st
    else
        sudo xbps-install -S base-devel git libX11-devel libXft-devel libXinerama-devel
    fi
}

Suckless(){
    if [[ ! -d "$HOME/Suckless" ]]; then
        echo "hi"
    else
        echo "done"
    fi

}


Main(){
    Install_dwm
}

