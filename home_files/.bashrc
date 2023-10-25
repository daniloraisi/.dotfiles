HOME_DIR=$HOME

if test -v GITPOD_REPO_ROOT; then {
	HOME_DIR=$GITPOD_REPO_ROOT
}; fi

if (test "$PPID" == "$(pgrep -f '/ide/xterm/bin/node /ide/xterm/index.cjs' | head -n1)"); then {
	gitpod_zellij &
	disown
	if ! zellij has-sessions 2>/dev/null; then {
		exec zellij -s gitpod
	}; fi

	exec zellij attach
}; elif [ -x "$(command -v tmux)" ] && [ -z "${TMUX}" ]; then {
	exec tmux new-session -A -s ${USER} -c "${HOME_DIR}" >/dev/null 2>&1
}; fi

