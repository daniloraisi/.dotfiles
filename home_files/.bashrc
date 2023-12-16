HOME_DIR=$HOME

if test -v GITPOD_REPO_ROOT; then {
	HOME_DIR=$GITPOD_REPO_ROOT
}; else {
	exec tmux new-session -A -s ${USER} -c "${HOME_DIR}" >/dev/null 2>&1
}; fi

if ! test -v ZELLIJ && test -v SSH_CONNECTION; then {
	gitpod_zellij & disown
	if ! zellij has-sessions 2>/dev/null; then {
		exec zellij -s gitpod
	}; fi

	exec zellij attach
}; elif (test "$PPID" == "$(pgrep -f '/ide/xterm/bin/node /ide/xterm/index.cjs' | head -n1)" || test "$TERM" == "xterm") && [ -x "$(command -v tmux)" ] && [ -z "${TMUX}" ]; then {
	exec tmux new-session -A -s ${USER} -c "${HOME_DIR}" >/dev/null 2>&1
}; fi

