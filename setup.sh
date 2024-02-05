#!/usr/bin/env bash

#                                                                                           
#  ,--.             ,--.        ,--,--.    ,------.         ,--. ,------,--,--.             
#  |  ,--,--, ,---,-'  '-.,--,--|  |  |    |  .-.  \ ,---.,-'  '-|  .---`--|  |,---. ,---.  
#  |  |      (  .-'-.  .-' ,-.  |  |  |    |  |  \  | .-. '-.  .-|  `--,,--|  | .-. (  .-'  
#  |  |  ||  .-'  `)|  | \ '-'  |  |  |    |  '--'  ' '-' ' |  | |  |`  |  |  \   --.-'  `) 
#  `--`--''--`----' `--'  `--`--`--`--'    `-------' `---'  `--' `--'   `--`--'`----`----'  
#                                                                                           
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
) >/dev/null 2>&1


#                                                                           
#  ,--.             ,--.        ,--,--.    ,-------.     ,--,--,--.    ,--. 
#  |  ,--,--, ,---,-'  '-.,--,--|  |  |    `--.   / ,---.|  |  `--'    |  | 
#  |  |      (  .-'-.  .-' ,-.  |  |  |      /   / | .-. |  |  ,--,--. |  | 
#  |  |  ||  .-'  `)|  | \ '-'  |  |  |     /   `--\   --|  |  |  |  '-'  / 
#  `--`--''--`----' `--'  `--`--`--`--'    `-------'`----`--`--`--'`-----'  
#                                                                           
(
	sudo bash <<'SCRIPT'
# Install latest static zellij
curl -L "https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz" |
  tar -C /usr/bin -xzf - zellij
SCRIPT
) >/dev/null 2>&1


#                                                                       ,--.                                     
#  ,--.             ,--.        ,--,--.    ,------,--.     ,--.        /  ,--------,--.   ,--,--. ,--,--.   ,--. 
#  |  ,--,--, ,---,-'  '-.,--,--|  |  |    |  .---`--',---.|  ,---.   /  /'--.  .--|   `.'   |  | |  |\  `.'  /  
#  |  |      (  .-'-.  .-' ,-.  |  |  |    |  `--,,--(  .-'|  .-.  | /  /    |  |  |  |'.'|  |  | |  | .'    \   
#  |  |  ||  .-'  `)|  | \ '-'  |  |  |    |  |`  |  .-'  `|  | |  |/  /     |  |  |  |   |  '  '-'  '/  .'.  \  
#  `--`--''--`----' `--'  `--`--`--`--'    `--'   `--`----'`--' `--/  /      `--'  `--'   `--'`-----''--'   '--' 
#                                                                 `--'                                           
if command -v apt >/dev/null; then {
	(
		sudo bash <<'SCRIPT'
command -v fish >/dev/null || add-apt-repository -y ppa:fish-shell/release-3 && apt install -yq fish
command -v tmux >/dev/null || apt install -yq tmux
SCRIPT

		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
		"$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh"

		rm -rf ~/.bash_history && ln -s /dev/null ~/.bash_history
	) >/dev/null 2>&1 &
 }; fi


#                                                                                                      
#  ,--.             ,--.        ,--,--.    ,--.  ,--.                    ,--.                          
#  |  ,--,--, ,---,-'  '-.,--,--|  |  |    |  '--'  |,---.,--,--,--.,---.|  |-.,--.--.,---.,--.   ,--. 
#  |  |      (  .-'-.  .-' ,-.  |  |  |    |  .--.  | .-. |        | .-. | .-. |  .--| .-. |  |.'.|  | 
#  |  |  ||  .-'  `)|  | \ '-'  |  |  |    |  |  |  ' '-' |  |  |  \   --| `-' |  |  \   --|   .'.   | 
#  `--`--''--`----' `--'  `--`--`--`--'    `--'  `--'`---'`--`--`--'`----'`---'`--'   `----'--'   '--' 
#                                                                                                      
(
	command -v brew >/dev/null || (
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	)

	/home/linuxbrew/.linuxbrew/bin/brew install starship bat eza fd ripgrep fzf procs zoxide lazygit asdf luarocks helix
) >/dev/null 2>&1 &


#                                                                          
#  ,--.             ,--.        ,--,--.    ,--.  ,--.        ,--.          
#  |  ,--,--, ,---,-'  '-.,--,--|  |  |    |  ,'.|  ,--.  ,--`--,--,--,--. 
#  |  |      (  .-'-.  .-' ,-.  |  |  |    |  |' '  |\  `'  /,--|        | 
#  |  |  ||  .-'  `)|  | \ '-'  |  |  |    |  | `   | \    / |  |  |  |  | 
#  `--`--''--`----' `--'  `--`--`--`--'    `--'  `--'  `--'  `--`--`--`--' 
#                                                                          
(
	sudo bash <<'SCRIPT'
cd /tmp
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar zxf nvim-linux64.tar.gz
mv nvim-linux64 /usr/local/nvim-linux
ln -s /usr/local/nvim-linux/bin/nvim /usr/local/bin/nvim
SCRIPT

	git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
	git clone https://github.com/daniloraisi/astronvim ~/.config/nvim/lua/user
	nvim --headless -c 'quitall'
) >/dev/null 2>&1 &

#                                                                            
#    ,---.            ,--.          ,---.                  ,--.,---,--.      
#   /  O  \,--.--.,---|  ,---.     '   .-' ,---. ,---. ,---`--/  .-`--',---. 
#  |  .-.  |  .--| .--|  .-.  |    `.  `-.| .-. | .-. | .--,--|  `-,--| .--' 
#  |  | |  |  |  \ `--|  | |  |    .-'    | '-' \   --\ `--|  |  .-|  \ `--. 
#  `--' `--`--'   `---`--' `--'    `-----'|  |-' `----'`---`--`--' `--'`---' 
#                                         `--'                               
#  ==========================================================================
#  This step is not executed in background
#  ==========================================================================
if command -v pacman >/dev/null; then {
	(
		sudo bash <<'SCRIPT'
pacman -S --needed --noconfirm git base-devel wget curl tmux fish
SCRIPT
    bash <<'SCRIPT'
cd /tmp
git clone https://aur.archlinux.org/paru-bin
cd paru-bin
makepkg -si --noconfirm
paru -S --needed hyprland waybar rofi-lbonn-wayland kitty swww pipewire-{pulse,jack,alsa} wireplumber pavucontrol nwg-look-bin nautilus dunst playerctl wttrbar qt5-imageformats polkit-kde-agent xdg-desktop-portal-hyprland qt{5,6}-wayland cliphist sddm microsoft-edge-stable-bin
SCRIPT
	)
}; fi
