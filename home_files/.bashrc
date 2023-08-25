HOME_DIR=$HOME

if test -v GITPOD_REPO_ROOT; then {
    HOME_DIR=$GITPOD_REPO_ROOT
}; fi

if [ -x "$(command -v tmux)" ] && [ -z "${TMUX}" ]; then
    exec tmux new-session -A -s ${USER} -c "${HOME_DIR}" >/dev/null 2>&1
fi