# main maybe
#!/bin/bash

Options=$1
Options2=$2

Arch_pack() {
    echo "Installing variour package fastfetch ghostty fd ripgrep tmux zsh btop curl wget trash-cli gcc nodejs npm "
    sudo pacman -S --noconfirm --needed fastfetch ghostty fd ripgrep tmux zsh \
        btop curl wget trash-cli gcc nodejs npm neovim fzf github-cli tree-sitter-cli\
        telegram-desktop obs-studio acpi mpv yt-dlp eza bc w3m lazygit thunar ristretto\
        thunar-volman gvfs tumbler thunar-archive-plugin unzip imagemagick ufw\
        man-db tig xfce4-screenshooter

    echo "Installing font"
    sudo pacman -S --noconfirm --needed ttf-jetbrains-mono-nerd ttf-terminus-nerd ttf-jetbrains-mono
    fc-cache -f -v
}

void_pack(){
    # soon
    echo "voiding"
    bash "$HOME/dev/void.sh"
}

Install_wallie() {
    if [[ ! -f "$HOME/Pictures/anime_waifu.jpg" ]]; then
        mkdir "$HOME/Pictures"
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
    if [[ ! -d "$HOME/.config/nvim/" ]]; then
        echo "Nvim setuping.."
        rm -rf ~/.config/nvim
        mkdir -p ~/.config/nvim
        git clone https://github.com/hellopradeep69/nvim.git ~/.config/nvim/
    fi
}

Ghostty_setup() {
    echo ""
    echo "Resetting ghostty config"
    trash ~/.config/ghostty
    mkdir -p ~/.config/ghostty
    cp -r $HOME/dev/resource/ghostty/. ~/.config/ghostty/
}

Install_theme(){
    sudo pacman -S --noconfirm --needed arc-gtk-theme-eos eos-qogir-icons
}


Zathura_install(){
    echo ""
    echo "Resetting Zathura config"
    trash ~/.config/zathura
    mkdir -p ~/.config/zathura/
    cp -r $HOME/dev/resource/zathura/. ~/.config/zathura/
}



Rofi_setup(){
    echo ""
    if [[ ! -d "$HOME/.config/rofi/" ]]; then
        echo "Rofi Config setup"
        mkdir -p ~/.config/rofi/
        trash ~/.config/rofi/
        cp -r $HOME/dev/resource/rofi/. ~/.config/rofi/
    fi
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

Application_install(){
    echo "installing .desktop"
    if [[ ! -d "$HOME/.local/share/applications" ]]; then
        mkdir -p "$HOME/.local/share/applications"
        echo "created dir"
    fi

    trash "$HOME/.local/share/applications/"

    #TODO: If zen command not found add application - useful for void
    cp -r $HOME/dev/resource/application/. $HOME/.local/share/applications/
    echo "Applications copied to $HOME/.local/share/applications"
}

Zen_install(){
    if ! command -v zen >/dev/null 2>&1;then
        wget -qO- https://github.com/zen-browser/desktop/releases/latest/download/zen.linux-x86_64.tar.xz | sudo tar xJ -C /opt
        echo "Extracting zen"
        sudo ln -sf /opt/zen/zen /usr/bin/zen-browser
        echo "zen installed"
    fi
}

Zen_app(){
    echo "zenning"
    Zen_install

    cp -r $HOME/dev/resource/zen/. $HOME/.local/share/applications/
    echo "zen copied to $HOME/.local/share/applications"
}

Qute_app(){
    if command -v qutebrowser >/dev/null 2>&1;then
        cp -r $HOME/dev/resource/qutebrowser/config.py $HOME/.config/qutebrowser/config.py
        echo "qutebrowser copied to $HOME/.local/share/applications"
    fi
}

W3m_config(){
    if command -v w3m >/dev/null 2>&1;then
        cp -r $HOME/dev/resource/w3m/keymap $HOME/.w3m/keymap
        echo "w3m config reloaded to $HOME/.w3m/"
    fi
}


Firewall_setup(){
    if command -v systemctl >/dev/null 2>&1;then
        sudo systemctl enable ufw
        sudo systemctl start ufw

        sudo ufw default deny incoming
        sudo ufw default allow outgoing
    else
        echo "activate your own firewall"
    fi
}

Yay_install(){
    if command -v yay >/dev/null 2>&1;then
        echo ""
        echo "Yay already downloaded"
    else
        sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
    fi
}

Say_arch(){
echo ""
echo "Now You can proudly say I use arch btw"
echo ""
}

Main() {
    Install_wallie
    Tmux_in
    Nvim_setup
    Firewall_setup
    Rofi_setup
    Zathura_install
    Qute_app
    W3m_config
    Zsh_setup
    Script_install
    Application_install
    Ghostty_setup
    echo ""
    echo "Basic Setup done for your linux"
}

Arch_install(){
    Arch_pack
    Yay_install
    Main
}

Void_install(){
    void_pack
    Main
    Zen_app
}


Help(){
    # TODO: add help
    echo "Usage:"
    echo "distro available : void and arch"
    echo " "
    echo "./dev.sh -arch -hyprland        to install hyprland and config in arch"
    echo "./dev.sh -arch -sway            to install sway and config in arch"
    echo "./dev.sh -arch -i3              to install i3wm and config in arch"
    echo "bash dev.sh -void -i3           to install i3wm and config in void"
    echo " "
    echo "           * void script only support i3-wm for now"
}

case "$Options" in
    -help)
        Help
        ;;
    -nix)
        Main
        ;;
    -arch)
        Arch_install
        ;;
    -void)
        Void_install
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
        Help
        ;;
esac

case "$Options2" in
    -hyprland)
        bash $HOME/dev/hyprland.sh
        ;;
    -sway)
        bash $HOME/dev/sway.sh
        ;;
    -i3)
        bash $HOME/dev/i3wm.sh
        ;;
    -yay)
        sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
        ;;
    -theme)
        Install_theme
        ;;
esac


echo ""
echo ".... Setup completed ...."
echo ""
