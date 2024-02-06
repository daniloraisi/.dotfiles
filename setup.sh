#!/usr/bin/env bash

#┏━━┓━━━━━━━━━┏┓━━━━━━┏┓━┏┓━━━━━┏━━━┓━━━━━┏┓━━┏━━━┓━━┏┓━━━━━━━━━
#┗┫┣┛━━━━━━━━┏┛┗┓━━━━━┃┃━┃┃━━━━━┗┓┏┓┃━━━━┏┛┗┓━┃┏━━┛━━┃┃━━━━━━━━━
#━┃┃━┏━┓━┏━━┓┗┓┏┛┏━━┓━┃┃━┃┃━━━━━━┃┃┃┃┏━━┓┗┓┏┛━┃┗━━┓┏┓┃┃━┏━━┓┏━━┓
#━┃┃━┃┏┓┓┃━━┫━┃┃━┗━┓┃━┃┃━┃┃━━━━━━┃┃┃┃┃┏┓┃━┃┃━━┃┏━━┛┣┫┃┃━┃┏┓┃┃━━┫
#┏┫┣┓┃┃┃┃┣━━┃━┃┗┓┃┗┛┗┓┃┗┓┃┗┓━━━━┏┛┗┛┃┃┗┛┃━┃┗┓┏┛┗┓━━┃┃┃┗┓┃┃━┫┣━━┃
#┗━━┛┗┛┗┛┗━━┛━┗━┛┗━━━┛┗━┛┗━┛━━━━┗━━━┛┗━━┛━┗━┛┗━━┛━━┗┛┗━┛┗━━┛┗━━┛
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
(
	current_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
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
)

#┏━━┓━━━━━━━━━┏┓━━━━━━┏┓━┏┓━━━━━┏━━━┓━━━━━━━━━┏┓━━━━━━━━━━━━━━━━━━━
#┗┫┣┛━━━━━━━━┏┛┗┓━━━━━┃┃━┃┃━━━━━┃┏━┓┃━━━━━━━━━┃┃━━━━━━━━━━━━━━━━━━━
#━┃┃━┏━┓━┏━━┓┗┓┏┛┏━━┓━┃┃━┃┃━━━━━┃┗━┛┃┏━━┓━┏━━┓┃┃┏┓┏━━┓━┏━━┓┏━━┓┏━━┓
#━┃┃━┃┏┓┓┃━━┫━┃┃━┗━┓┃━┃┃━┃┃━━━━━┃┏━━┛┗━┓┃━┃┏━┛┃┗┛┛┗━┓┃━┃┏┓┃┃┏┓┃┃━━┫
#┏┫┣┓┃┃┃┃┣━━┃━┃┗┓┃┗┛┗┓┃┗┓┃┗┓━━━━┃┃━━━┃┗┛┗┓┃┗━┓┃┏┓┓┃┗┛┗┓┃┗┛┃┃┃━┫┣━━┃
#┗━━┛┗┛┗┛┗━━┛━┗━┛┗━━━┛┗━┛┗━┛━━━━┗┛━━━┗━━━┛┗━━┛┗┛┗┛┗━━━┛┗━┓┃┗━━┛┗━━┛
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┏━┛┃━━━━━━━━
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┗━━┛━━━━━━━━
if command -v pacman >/dev/null; then {
	(
		sudo bash <<'SCRIPT'
pacman -S --needed --noconfirm git base-devel wget curl tmux fish
SCRIPT

		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
		$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh
	
		rm -rf ~/.bash_history && ln -s /dev/null ~/.bash_history

    bash <<'SCRIPT'
cd /tmp
git clone https://aur.archlinux.org/paru-bin
cd paru-bin
makepkg -si --noconfirm
paru -S --needed --noconfirm \
	hyprland waybar rofi-lbonn-wayland kitty pipewire-{pulse,jack,alsa} wireplumber xdg-desktop-portal-{hyprland,gtk}	swww pavucontrol \
	nwg-look-bin nautilus dunst playerctl wttrbar qt5-imageformats polkit-kde-agent xdg-desktop-portal-hyprland qt{5,6}-wayland \
	cliphist sddm-git microsoft-edge-stable-bin swaylock-effects-git grim slurp swappy light-git pamixer wttrbar keychain \
	catppuccin-gtk-theme-macchiato sevi-icon-theme-full ttf-jetbrains-mono-nerd swayidle-git input-remapper-git
SCRIPT
	)
}; fi

#┏━━┓━━━━━━━━━┏┓━━━━━━┏┓━┏┓━━━━━┏┓━┏┓━━━━━━━━━━━━┏┓━━━━━━━━━━━━━━━
#┗┫┣┛━━━━━━━━┏┛┗┓━━━━━┃┃━┃┃━━━━━┃┃━┃┃━━━━━━━━━━━━┃┃━━━━━━━━━━━━━━━
#━┃┃━┏━┓━┏━━┓┗┓┏┛┏━━┓━┃┃━┃┃━━━━━┃┗━┛┃┏━━┓┏┓┏┓┏━━┓┃┗━┓┏━┓┏━━┓┏┓┏┓┏┓
#━┃┃━┃┏┓┓┃━━┫━┃┃━┗━┓┃━┃┃━┃┃━━━━━┃┏━┓┃┃┏┓┃┃┗┛┃┃┏┓┃┃┏┓┃┃┏┛┃┏┓┃┃┗┛┗┛┃
#┏┫┣┓┃┃┃┃┣━━┃━┃┗┓┃┗┛┗┓┃┗┓┃┗┓━━━━┃┃━┃┃┃┗┛┃┃┃┃┃┃┃━┫┃┗┛┃┃┃━┃┃━┫┗┓┏┓┏┛
#┗━━┛┗┛┗┛┗━━┛━┗━┛┗━━━┛┗━┛┗━┛━━━━┗┛━┗┛┗━━┛┗┻┻┛┗━━┛┗━━┛┗┛━┗━━┛━┗┛┗┛━
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
(
	command -v brew >/dev/null || (
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	)

	/home/linuxbrew/.linuxbrew/bin/brew install starship bat eza fd ripgrep fzf procs zoxide lazygit asdf luarocks helix neovim
	/home/linuxbrew/.linuxbrew/opt/fzf/install --key-bindings --completion --update-rc --no-bash --no-zsh
)

#┏━━┓━━━━━━━━━┏┓━━━━━━┏┓━┏┓━━━━━┏━┓━┏┓━━━━━━━━━━
#┗┫┣┛━━━━━━━━┏┛┗┓━━━━━┃┃━┃┃━━━━━┃┃┗┓┃┃━━━━━━━━━━
#━┃┃━┏━┓━┏━━┓┗┓┏┛┏━━┓━┃┃━┃┃━━━━━┃┏┓┗┛┃┏┓┏┓┏┓┏┓┏┓
#━┃┃━┃┏┓┓┃━━┫━┃┃━┗━┓┃━┃┃━┃┃━━━━━┃┃┗┓┃┃┃┗┛┃┣┫┃┗┛┃
#┏┫┣┓┃┃┃┃┣━━┃━┃┗┓┃┗┛┗┓┃┗┓┃┗┓━━━━┃┃━┃┃┃┗┓┏┛┃┃┃┃┃┃
#┗━━┛┗┛┗┛┗━━┛━┗━┛┗━━━┛┗━┛┗━┛━━━━┗┛━┗━┛━┗┛━┗┛┗┻┻┛
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
(
	rm -rf ~/.local/{share,state}/nvim
  rm -rf ~/.cache/nvim
	git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
	git clone https://github.com/daniloraisi/astronvim ~/.config/nvim/lua/user
	nvim --headless -c 'quitall'
)

