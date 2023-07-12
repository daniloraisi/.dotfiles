#!/usr/bin/env bash

(
	(
		# Install TMUX and fish for use on SSH Connections
		sudo curl -L https://github.com/axonasif/build-static-tmux/releases/latest/download/tmux.linux-amd64.stripped -o /usr/bin/tmux
		sudo chmod +x /usr/bin/tmux

		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
		"$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh"

		sudo apt update

		command -v fish >/dev/null || sudo apt-get install -yq fish
	)

	(
		# Install zellij for use on Browser Terminal
		curl -L "https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz" |
			tar -C /usr/bin -xzf - zellij

		plugin_path="/usr/bin/gitpod_zellij"
		curl -L "https://github.com/axonasif/gitpod.zellij/releases/latest/download/gitpod_zellij-x86_64-unknown-linux-musl.tar.gz" |
			tar -C /usr/bin -xzf - gitpod_zellij
	)

	rm -rf ~/.bash_history && ln -s /dev/null ~/.bash_history
)
