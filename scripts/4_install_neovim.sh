(
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	chmod +x nvim.appimage
	./nvim.appimage --appimage-extract
	sudo mv squashfs-root /usr/local/nvim
	sudo ln -s /usr/local/nvim/AppRun /usr/local/bin/nvim
	rm -rf nvim.appimage
)
