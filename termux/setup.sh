#!/usr/bin/env bash

REPO="$(pwd)"

# install essentinal package
Install_pkg() {
    echo "updating package"
    pkg update && pkg upgrade -y
    pkg install git curl wget vim nano htop zsh lazygit tmux zsh -y
}

# Local bin in bash
Bash_bin() {
    "making sure your local bin has permission to do"
    mkdir -p ~/.local/bin
    echo 'export PATH="$HOME/.local/bin:$PATH"' >>~/.bashrc
    echo " Added ~/.local/bin to PATH in .bashrc"
    source ~/.bashrc
}

# Access to storage
Access_termux() {
    echo " Requesting storage access..."
    termux-setup-storage
    echo "Permission granted"
}

#do you wanna use zsh
Install_zsh() {
    # sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

Copy_file() {
    cp -r "$REPO/.tmux.conf" "$HOME/."
    cp -r "$REPO/.zshrc" "$HOME/."
    echo "copied tmux and zshrc "
}

Main() {
    Install_pkg
    Access_termux
    Bash_bin
    Install_zsh
    Copy_file
}
