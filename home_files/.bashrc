export ZELLIJ_AUTO_EXIT=true

eval "$(keychain --quiet --eval id_ed25519 ~/.ssh/id_ed25519)"

if [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]]; then {
	eval "$(zellij setup --generate-auto-start bash)"
}; fi
