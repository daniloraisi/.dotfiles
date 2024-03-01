# ~/.zshrc
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

zstyle ':completion:*:git:*' group-order 'main commands' 'alias commands' 'external commands'

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
