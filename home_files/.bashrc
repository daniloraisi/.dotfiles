eval $(keychain --quiet --eval id_ed25519 ~/.ssh/id_ed25519)

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux new-session -A -s ${USER} -c "${HOME_DIR}" >/dev/null 2>&1
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
