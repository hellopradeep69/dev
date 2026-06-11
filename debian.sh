#!/usr/bin/env bash
# https://www.atulhost.com/20-essential-things-to-do-after-installing-debian

# Ghostty version
VERSION=1.3.1
ARCH=x86_64

Debian_util() {
	echo "Installling essential package...."
	sudo apt update && sudo apt upgrade
	sudo apt install curl wget git tmux zsh fd-find btop trash-cli gcc \
		mpv bc w3m unzip firefox zip
}

Install_fzf() {
	git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/dev/.fzf"
	$HOME/dev/.fzf/install
	trash $HOME/dev/.fzf
}

Install_eza() {
	wget -c https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -O - | tar xz
	sudo chmod +x eza
	sudo chown root:root eza
	sudo mv eza /usr/local/bin/eza
}

Install_ghostty() {
	wget https://github.com/pkgforge-dev/ghostty-appimage/releases/download/v${VERSION}/Ghostty-${VERSION}-${ARCH}.AppImage
	chmod +x Ghostty-${VERSION}-${ARCH}.AppImage

	# With sudo for system wide availability
	sudo install ./Ghostty-${VERSION}-${ARCH}.AppImage /usr/local/bin/ghostty
}

Install_fd() {
	sudo apt install fd-find
	if [ ! -f "$HOME/.local/bin/fd" ]; then
		ln -s $(which fdfind) $HOME/.local/bin/fd
	fi
}

Install_ripgrep() {
	curl -LO https://github.com/BurntSushi/ripgrep/releases/download/15.1.0/ripgrep_15.1.0-1_amd64.deb
	sudo dpkg -i ripgrep_15.1.0-1_amd64.deb
}

Install_nvim() {
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
	sudo rm -rf /opt/nvim-linux-x86_64
	sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
	# TODO: WHat to do with below
	export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
}

Install_ytdlp() {
	sudo add-apt-repository ppa:tomtomtom/yt-dlp
	sudo apt update
	sudo apt install yt-dlp
}

# FIXME: I assume it work
Install_font() {
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

Thunar_theme() {
	# if [[ ! -d "$HOME/.themes/Qogir" ]]; then
	if [[ -d "$HOME/.themes/Qogir" ]]; then
		echo "installing theme yes yes yes"
		git clone https://github.com/vinceliuice/Qogir-theme.git
		"$PWD/Qogir-theme/install.sh"
		echo "Thank you theme bye bye"
		trash "$PWD/Qogir-theme"
	fi

	if [[ ! -d "$HOME/.local/share/icons/Qogir" ]]; then
		echo "installing icon yes yes yes"
		git clone https://github.com/vinceliuice/Qogir-icon-theme.git
		"$PWD/Qogir-icon-theme/install.sh" -t default
		echo "Thank you icon bye bye"
		trash "$PWD/Qogir-icon-theme"
	fi
}

Main() {
	Debian_util
	Install_fzf
	Install_eza
	Install_ghostty
	Install_fd
	Install_ripgrep
	Install_nvim
	Install_ytdlp
	Install_font
	Thunar_theme
}

if command -v apt >/dev/null; then
	echo "hello debian"
	Main
else
	echo "nah you aint debian"
fi
