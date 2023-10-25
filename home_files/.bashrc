HOME_DIR=$HOME

if test -v GITPOD_REPO_ROOT; then {
	HOME_DIR=$GITPOD_REPO_ROOT
}; fi

if ! test -v ZELLIJ && (test "$PPID" == "$(pgrep -f '/ide/xterm/bin/node /ide/xterm/index.cjs' | head -n1)") && [ -x "$(command -v tmux)" ] && [ -z "${TMUX}" ]; then {
	gitpod_zellij &
	disown
	if ! zellij has-sessions 2>/dev/null; then {
		exec zellij -s gitpod
	}; fi

	exec zellij attach
}; elif pgrep -f "$HOME/.vscode-server/bin" 1>/dev/null && test -v SSH_CONNECTION; then {
	exec tmux new-session -A -s ${USER} -c "${HOME_DIR}" >/dev/null 2>&1
}; fi

