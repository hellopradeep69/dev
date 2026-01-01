# main maybe
#!/usr/bin/env bash

Void_util(){
    echo "instaling the essential"
    sudo xbps-install -S --yes  NetworkManager pipewire linux-firmware-amd dbus runit-iptables

}

Void_pack() {
    echo "Installing variour package fastfetch ghostty fd ripgrep tmux zsh btop curl wget trash-cli gcc nodejs npm "
    sudo xbps-install -S --yes  fastfetch ghostty fd ripgrep tmux zsh \
        btop curl wget trash-cli gcc nodejs neovim fzf github-cli tree-sitter\
        telegram-desktop obs-studio acpi mpv yt-dlp eza bc w3m lazygit unzip  \
        flameshot man-db
    }

Font_install(){
    echo "Installing font"
    mkdir -p ~/.local/share/fonts

    if [ ! -f "$HOME/.local/share/fonts/JetBrainsMonoNerdFont-Regular.ttf" ]; then
    wget -O JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
    unzip JetBrainsMono.zip -d ~/.local/share/fonts
    fi

    sudo xbps-install -S --yes terminus-font font-iosevka

    fc-cache -f -v
}

Start_i3(){
    if [[ ! -f "$HOME/.xinitrc" ]]; then
        cat > "$HOME/.xinitrc" << 'EOF'
#!/bin/sh
exec /bin/i3
EOF
chmod +x "$HOME/.xinitrc"
    fi
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
    Start_i3
    Enable_service
    Disable_service
}

Main
