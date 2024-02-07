# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/danilo/.zshrc'

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

ZELLIJ_AUTO_EXIT=true
eval "$(zellij setup --generate-auto-start zsh)"

autoload -Uz compinit
compinit
# End of lines added by compinstall
