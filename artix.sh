# main maybe
#!/bin/bash

echo "Installing variour package fastfetch ghostty fd ripgrep tmux zsh btop curl wget trash-cli gcc nodejs npm "

sudo pacman -Syu fastfetch ghostty fd ripgrep tmux zsh \
	btop curl wget trash-cli gcc nodejs npm neovim fzf github-cli tree-sitter-cli \
	telegram-desktop obs-studio acpi mpv yt-dlp eza bc w3m lazygit thunar ristretto \
	thunar-volman gvfs tumbler thunar-archive-plugin unzip imagemagick \
	ufw man-db tig xfce4-screenshooter w3m

echo "Installing font"
sudo pacman -Syu ttf-jetbrains-mono-nerd ttf-terminus-nerd ttf-jetbrains-mono
fc-cache -f -v

sudo pacman -Syu i3-wm i3lock i3status dunst rofi xclip \
	copyq picom brightnessctl lxappearance adapta-gtk-theme
