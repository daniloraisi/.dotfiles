HOME_DIR=$HOME

if test -v GITPOD_REPO_ROOT; then {
	HOME_DIR=$GITPOD_REPO_ROOT
}; fi

if test ! -v TMUX && (test -v SSH_CONNECTION || test "$PPID" == "$(pgrep -f '/ide/xterm/bin/node /ide/xterm/index.cjs' | head -n1)"); then {
	# if test ! -v TMUX && test -v SSH_CONNECTION; then {
	if ! tmux has-session 2>/dev/null; then {
		tmux new-session -n "editor" -ds "gitpod" -c "$HOME_DIR"
	}; fi

	exec tmux attach
	# }; elif test ! -v ZELLIJ && ! pgrep -f "$HOME/.vscode-server/bin" 1>/dev/null && test "$PPID" == "$(pgrep -f '/ide/xterm/bin/node /ide/xterm/index.cjs' | head -n1)"; then {
	# 	gitpod_zellij &
	# 	disown
	#
	# 	if ! zellij has-session 2>/dev/null; then {
	# 		exec zellij -s gitpod
	# 	}; fi
	#
	# 	exec zellij attach
}; fi
