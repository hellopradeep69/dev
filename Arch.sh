#!/bin/bash
# My development setup for linux Arch

Options=$1

Install_pack() {
    echo "Installing variour package fastfetch ghostty fd ripgrep tmux zsh btop curl wget trash-cli gcc nodejs npm "
    sudo pacman -S --noconfirm --needed fastfetch ghostty fd ripgrep tmux zsh \
        btop curl wget trash-cli gcc nodejs npm wl-clipboard cliphist grim \
        telegram-desktop obs-studio acpi mpv yt-dlp eza bc w3m lazygit

}

Install_font() {
    echo "Installing font"
    sudo pacman -S --noconfirm --needed ttf-jetbrains-mono-nerd ttf-terminus-nerd ttf-jetbrains-mono
    # fc-cache -f -v
}

Install_wallie() {
    if [[ ! -f "$HOME/Pictures/anime_waifu.jpg" ]]; then
        echo "Arch comes with anime waifu"
        cp "$HOME/dev/resource/wallpaper/anime_waifu.jpg" "$HOME/Pictures/"
        cp "$HOME/dev/resource/wallpaper/Arch.jpg" "$HOME/Pictures/"
    fi
}

Zsh_setup() {
    Shell=$(echo "$SHELL")
    if [[ $Shell == "/usr/bin/zsh" ]]; then
        echo "zsh"
    else
        echo "not zsh"
        chsh -s $(which zsh)
    fi

    echo "Reinstalling zsh and zsh conf"
    [[ -f "$HOME/.zshrc" ]] && trash "$HOME/.zshrc"
    cp "$HOME/dev/.zshrc" "$HOME/.zshrc"

}

Tmux_in() {
    echo ""
    echo "Reinstalling tmux and tmux conf"
    [[ -f "$HOME/.tmux.conf" ]] && trash "$HOME/.tmux.conf"
    cp -r "$HOME/dev/.tmux.conf" "$HOME/.tmux.conf"
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

Ghostty_setup() {
    echo ""
    echo "Resetting ghostty config"
    trash ~/.config/ghostty
    mkdir -p ~/.config/ghostty
    cp -r $HOME/dev/resource/ghostty/. ~/.config/ghostty/
}

Script_install() {
    echo "Scripting Install"

    echo "trashing scripts"
    trash "$HOME/.local/bin/"
    mkdir -p "$HOME/.local/bin/"

    echo " "
    cp -r $HOME/dev/resource/scripts/. $HOME/.local/bin/
    echo "Scripts copied to $HOME/.local/bin/"
}

Main() {
    # Install_font
    Install_pack
    Install_wallie
    #commented out uncomment when first time
    Tmux_in
    # Nvim_setup
    # Zsh_setup #commented out uncomment when first time
    # Script_install #commented out uncomment when first time
    # Ghostty_setup
    echo ""
    echo "Basic Setup done"
}

case "$Options" in
-help)
    echo "Usage:"
    echo "./Arch.sh -hyprland        to install hyprland and config"
    echo "./Arch.sh -sway            to install sway and config"
    echo "./Arch.sh -i3              to install i3wm and config"
    ;;
-hyprland)
    bash $HOME/dev/hyprland.sh
    ;;
-sway)
    bash $HOME/dev/sway.sh
    ;;
-i3)
    bash $HOME/dev/i3wm.sh
    ;;
*)
    Main
    echo "-help for info on installing hyprland and sway "
    ;;
esac

echo ""
echo "Now You can proudly say I use arch btw"
echo ""
