#!/usr/bin/env bash

REPO="$(pwd)"

banner() {
    clear
    echo ""
    echo "╔═══════════════════════════════════╗"
    echo "║        Termux Setup Script        ║"
    echo "╚═══════════════════════════════════╝"
    echo " "
    echo ""
    echo "do you want to continue(Y/n)"
    read -r value
    if [[ "$value" = "n" ]]; then
        echo "Aborting setup"
        exit 0
    elif [[ "$value" = "y" || "$value" = "Y" ]]; then
        echo "Starting setup..."
    else
        echo "Invalid input. Aborting."
        exit 1
    fi
}

# install essentinal package
Install_pkg() {
    echo "updating package"
    pkg update -y && pkg upgrade -y

    echo "Installing essential packages..."
    pkg install -y git curl wget vim nano htop zsh tmux python neovim iproute2 fzf npm eza
}

# Local bin in bash
Bash_bin() {
    echo "making sure your local bin has permission to do"
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

Set_zsh() {
    echo "Setting Zsh as default shell for Termux..."
    # Termux doesn't support `chsh`, so we modify the startup behavior manually
    if ! grep -q "exec zsh" "$HOME/.bashrc"; then
        echo 'exec zsh' >>"$HOME/.bashrc"
        echo "Added 'exec zsh' to .bashrc — Zsh will now start automatically."
    fi
}

#do you wanna use zsh
Zsh_setup() {
    Shell=$(echo "$SHELL")
    if [[ $Shell == "/usr/bin/zsh" ]]; then
        echo "zsh"
    else
        echo "not zsh"
        Set_zsh
    fi

    echo "Reinstalling zsh and zsh conf"
    [[ -f "$HOME/.zshrc" ]] && trash "$HOME/.zshrc"
    cp "$HOME/dev/.zshrc" "$HOME/.zshrc"

}

Nvim_setup() {
    echo ""
    echo "Nvim setuping.."
    rm -rf ~/.config/nvim
    mkdir -p ~/.config/nvim
    git clone https://github.com/hellopradeep69/nvim.git ~/.config/nvim/
    rm -rf ~/.config/nvim/.git
    rm -rf ~/.config/nvim/README.md
}

Tmux_conf() {
    cp -r "$REPO/.tmux.conf" "$HOME/."
    echo "copied tmux and zshrc "
}


Main() {
    banner
    Install_pkg
    Access_termux
    Bash_bin
    Tmux_conf
    Zsh_setup
}

Main
