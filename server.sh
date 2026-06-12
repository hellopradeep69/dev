#!/usr/bin/env bash
# https://www.atulhost.com/20-essential-things-to-do-after-installing-debian

Debian_util() {
	echo "Installling essential package...."
	sudo apt update && sudo apt upgrade
	sudo apt install curl wget git tmux zsh fd-find btop trash-cli gcc \
		mpv bc w3m unzip zip
}

Install_fzf() {
	git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/dev/.fzf"
	bash "$HOME/dev/.fzf/install"
	trash $HOME/dev/.fzf
}

Install_eza() {
	wget -c https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -O - | tar xz
	sudo chmod +x eza
	sudo chown root:root eza
	sudo mv eza /usr/local/bin/eza
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
	trash "$HOME/dev/ripgrep_15.1.0-1_amd64.deb"
}

Install_nvim() {
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
	sudo rm -rf /opt/nvim-linux-x86_64
	sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
	trash "$HOME/dev/nvim-linux-x86_64.tar.gz"
	# TODO: WHat to do with below
	export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
}

Nvim_setup() {
	if [[ ! -d "$HOME/.config/nvim/" ]]; then
		echo ""
		echo "Nvim setuping.."
		rm -rf ~/.config/nvim
		mkdir -p ~/.config/nvim
		git clone https://github.com/hellopradeep69/mininvim.git ~/.config/nvim/
	fi
}

Tmux_in() {
	echo ""
	echo "Reinstalling tmux and tmux conf"
	[[ -f "$HOME/.tmux.conf" ]] && trash "$HOME/.tmux.conf"
	cp -r "$HOME/dev/resource/server/.tmux.conf" "$HOME/.tmux.conf"
}

Install_ytdlp() {
	sudo add-apt-repository ppa:tomtomtom/yt-dlp
	sudo apt update
	sudo apt install yt-dlp
}

Main() {
	Debian_util
	Install_fzf
	Install_eza
	Install_fd
	Install_ripgrep
	Install_nvim
	Nvim_setup
	Tmux_in
	Install_ytdlp
}

if command -v apt >/dev/null; then
	echo "hello debian server"
	Main
else
	echo "nah you aint debian"
fi
