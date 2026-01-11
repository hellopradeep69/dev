#!/usr/bin/env bash

Install_dwm(){
    echo "installing dwm and dependencies"
    if command -v pacman >/dev/null 2>&1;then
        sudo pacman -S --noconfirm --needed dwm dmenu st
    else
        sudo xbps-install -Sy dwm dmenu st
    fi
}


Main(){
    Install_dwm
}

