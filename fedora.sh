#!/usr/bin/env bash

Install_fed(){
    echo "Installing variour package fastfetch ghostty fd ripgrep tmux zsh btop curl wget trash-cli gcc nodejs npm "
    sudo dnf install -y fastfetch fd-find ripgrep tmux zsh \
        btop curl wget trash-cli gcc nodejs neovim fzf gh tree-sitter-cli \
        telegram-desktop obs-studio acpi mpv yt-dlp eza bc w3m lazygit unzip  \
        man-db ncurses-term make wezterm firefox xfce4-screenshooter copyq
    echo ""
}

Ghostty_install(){
    sudo dnf copr enable scottames/ghostty
    sudo dnf install ghostty
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
        unzip -o Terminus.zip -d "~/.local/share/fonts"
        rm Terminus.zip
        fc-cache -fv
    fi

    fc-cache -f -v
}

Main(){
    Install_fed
    Font_install
    Ghostty_install
}

Main
