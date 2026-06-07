#!/usr/bin/env bash

REPO="$(pwd)"

# install essentinal package
Install_pkg() {
	echo "updating package"
	pkg update -y && pkg upgrade -y

	echo "Installing essential packages..."
	pkg install -y git curl wget htop zsh tmux python neovim iproute2 fzf eza
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
		chsh -s $(which zsh)
		# Set_zsh
	fi

	echo "Reinstalling zsh and zsh conf"
	[[ -f "$HOME/.zshrc" ]] && trash "$HOME/.zshrc"
	cp "$HOME/dev/termux/.zshrc" "$HOME/.zshrc"

}

Nvim_setup() {
	echo ""
	echo "Nvim setuping.."
	rm -rf ~/.config/nvim
	mkdir -p ~/.config/nvim
	git clone https://github.com/hellopradeep70/mininvim.git ~/.config/nvim/
}

Main() {
	Install_pkg
	Access_termux
	Zsh_setup
	Nvim_setup
}

Main
