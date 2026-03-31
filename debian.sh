#!/usr/bin/env bash
# https://www.atulhost.com/20-essential-things-to-do-after-installing-debian

Debian_util(){
    echo "Installling essential package...."
    sudo apt update && sudo apt upgrade
    sudo apt install curl wget git tmux zsh fd-find btop trash-cli gcc \
    mpv bc w3m unzip firefox zip
}

# TODO: Maintain / check it frequently
Install_unofficial(){
    echo "Instaling unoffical stuff.."
    curl -sS https://debian.griffo.io/EA0F721D231FDD3A0A17B9AC7808B4DD62C41256.asc | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/debian.griffo.io.gpg
    echo "deb https://debian.griffo.io/apt $(lsb_release -sc 2>/dev/null) main" | sudo tee /etc/apt/sources.list.d/debian.griffo.io.list
    sudo apt update
    echo "Installling ghostty eza fzf lazygit"
    sudo apt install  ghostty yazi eza  fzf
}

Install_fd(){
    sudo apt install fd-find
    if [ ! -f "$HOME/.local/bin/fd" ]; then
        ln -s $(which fdfind) $HOME/.local/bin/fd
    fi
}

Install_ripgrep(){
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/15.1.0/ripgrep_15.1.0-1_amd64.deb
    sudo dpkg -i ripgrep_15.1.0-1_amd64.deb
}

Install_nvim(){
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    sudo rm -rf /opt/nvim-linux-x86_64
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
    # TODO: WHat to do with below
    export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
}

Install_ytdlp(){
    sudo add-apt-repository ppa:tomtomtom/yt-dlp
    sudo apt update
    sudo apt install yt-dlp
}


# FIXME: I assume it work
Install_font(){
    echo "Installing font"
    mkdir -p ~/.local/share/fonts

    if [ ! -f "$HOME/.local/share/fonts/JetBrainsMonoNerdFont-Regular.ttf" ]; then
        wget -O JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
        unzip JetBrainsMono.zip -d ~/.local/share/fonts
        rm JetBrainsMono.zip
    fi

    if [ ! -f "$HOME/.local/share/fonts/TerminessNerdFont-Regular.ttf" ]; then
        wget -O Terminus.zip \
            https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Terminus.zip
        unzip -o Terminus.zip -d ~/.local/share/fonts
        rm Terminus.zip
        fc-cache -fv
    fi

    echo "builing font for emoji and charc"

    fc-cache -f -v
}

Main(){
    Debian_util
    Install_unofficial
    Install_fd
    Install_ripgrep
    Install_nvim
    Install_ytdlp
    Install_font
}

if command -v apt >/dev/null; then
    echo "hello debian"
    Main
else
    echo "nah you aint debian"
fi
