# main maybe
#!/bin/bash

Void_util(){
    sudo xbps-install -S --yes  NetworkManager pipewire
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

    wget -O JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
    unzip JetBrainsMono.zip -d ~/.local/share/fonts

    sudo xbps-install -S -yes terminus-font font-iosevka

    fc-cache -f -v
}

Main(){
    Void_pack
    Font_install
}

Main
