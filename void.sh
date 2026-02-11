# main maybe
#!/usr/bin/env bash

Void_util(){
    echo "instaling the essential"
    sudo xbps-install -S --yes xorg NetworkManager pipewire linux-firmware-amd dbus  \
        xorg-input-drivers runit-iptables mesa mesa-dri mesa-vaapi mesa-vdpau \
        libva libva-utils ffmpeg
}

Void_pack() {
    echo "Installing variour package fastfetch ghostty fd ripgrep tmux zsh btop curl wget trash-cli gcc nodejs npm "
    sudo xbps-install -S --yes  fastfetch ghostty fd ripgrep tmux zsh \
        btop curl wget trash-cli gcc nodejs neovim fzf github-cli tree-sitter \
        telegram-desktop obs acpi mpv yt-dlp eza bc w3m lazygit unzip  \
        man-db ncurses-term make xfce4-screenshooter CopyQ tig xdg-utils ImageMagick
    echo ""
}

Font_install(){
    echo "Installing font"
    mkdir -p ~/.local/share/fonts

    if [ ! -f "$HOME/.local/share/fonts/JetBrainsMonoNerdFont-Regular.ttf" ]; then
        wget -O JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
        unzip JetBrainsMono.zip -d ~/.local/share/fonts
        rm JetBrainsMono.zip
    fi

    if [ ! -f "$HOME/.local/share/fonts/TerminusNerdFont-Regular.ttf" ]; then
        wget -O Terminus.zip \
            https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Terminus.zip
        unzip -o Terminus.zip -d ~/.local/share/fonts
        rm Terminus.zip
        fc-cache -fv
    fi

    echo "builing font for emoji and charc"
    sudo xbps-install -S --yes terminus-font noto-fonts-ttf noto-fonts-emoji

    fc-cache -f -v
    sudo xbps-reconfigure -f fontconfig
}


# sudo ln -s /etc/sv/<service> /var/service/
Enable_service(){
    echo "Enabling services..."

    for svc in dbus NetworkManager; do
        if [ ! -e "/var/service/$svc" ]; then
            sudo ln -s "/etc/sv/$svc" /var/service/
            echo "Enabling $svc"
        fi
    done
}

Disable_service(){
    echo "Disabling conflicting services..."

    for svc in dhcpcd wpa_supplicant; do
        if [ -e "/var/service/$svc" ]; then
            sudo sv down "$svc"
            sudo rm -f "/var/service/$svc"
            echo "Disabling $svc"
        fi
    done
}

Main(){
    Void_util
    Void_pack
    Font_install
    echo "try to prefer manual enable disable"
    # Enable_service
    # Disable_service
}

Main
