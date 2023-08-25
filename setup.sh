#!/usr/bin/env bash
(
    current_dir="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
    dotfiles_source="${current_dir}/home_files"

    while read -r file; do

        relative_file_path="${file#"${dotfiles_source}"/}"
        target_file="${HOME}/${relative_file_path}"
        target_dir="${target_file%/*}"

        if test ! -d "${target_dir}"; then
            mkdir -p "${target_dir}"
        fi

        printf 'Installing dotfiles symlink %s\n' "${target_file}"
        ln -sf "${file}" "${target_file}"

    done < <(find "${dotfiles_source}" -type f)
) >/dev/null 2>&1 

(
    command -v fish >/dev/null || sudo add-apt-repository -y ppa:fish-shell/release-3 && sudo apt install -yq fish
    command -v tmux >/dev/null || sudo apt install -yq tmux

    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    "$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh"

    rm -rf ~/.bash_history && ln -s /dev/null ~/.bash_history
) >/dev/null 2>&1 &

(
    command -v brew >/dev/null || (
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    )

    /home/linuxbrew/.linuxbrew/bin/brew install starship bat exa fd ripgrep fzf procs zoxide lazygit asdf
) >/dev/null 2>&1 &

(
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    tar zxf nvim-linux64.tar.gz
    sudo mv nvim-linux64 /usr/local/nvim-linux
    sudo ln -s /usr/local/nvim-linux/bin/nvim /usr/local/bin/nvim
    rm -rf nvim-linux64.tar.gz
) >/dev/null 2>&1 &