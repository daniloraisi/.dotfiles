(
	command -v brew >/dev/null || (
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	)

	/home/linuxbrew/.linuxbrew/bin/brew install starship bat exa fd ripgrep fzf procs zoxide lazygit asdf
	/home/linuxbrew/.linuxbrew/opt/fzf/install --no-bash --no-zsh
)
