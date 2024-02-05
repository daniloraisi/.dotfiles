export ZELLIJ_AUTO_EXIT=true

if [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]]; then {
	eval "$(zellij setup --generate-auto-start bash)"
}; fi
