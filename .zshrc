# Created by newuser for 5.9

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# export
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# russel theme
zi snippet OMZL::git.zsh
zi snippet OMZL::async_prompt.zsh
zi snippet OMZP::command-not-found
zi cdclear -q # <- forget completions provided up to this moment
setopt promptsubst
zi snippet OMZT::robbyrussell

# plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting

autoload -U compinit && compinit
autoload -U colors && colors
autoload -z edit-command-line

# cmp
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# opts
setopt interactivecomments
setopt append_history inc_append_history share_history
setopt autocd
setopt auto_param_slash
setopt no_case_glob no_case_match

# Add nvim as editor
export EDITOR="nvim"

# mkdir + cd
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# history opts
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zhistory
HISTDUP=erase
setopt hist_save_no_dups
setopt hist_ignore_all_dups
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# alias
alias ls='eza'
alias lh='eza -a'
alias :q="exit"

# fzf
source <(fzf --zsh)

# Locale fix for UTF-8
export LANG="en_IN.UTF-8"
export LANGUAGE="en_IN.UTF-8:en_US.UTF-8"
export LC_ALL="en_IN.UTF-8"

zle -N edit-command-line
bindkey "^e" edit-command-line

#  Enable vi keybindings + jj to escape
bindkey -v

# Map jj to escape insert mode
bindkey -M viins 'jj' vi-cmd-mode
bindkey -M vicmd "^e" edit-command-line
bindkey -a -r ':'

