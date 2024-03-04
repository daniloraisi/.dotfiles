eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

if test -d (brew --prefix)"/share/fish/completions"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
end

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

starship init fish | source
zoxide init --cmd cd fish | source

set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense'
mkdir -p ~/.config/fish/completions
carapace --list | awk '{print $1}' | xargs -I{} touch ~/.config/fish/completions/{}.fish
carapace _carapace | source

set -gx QT_STYLE_OVERRIDE kvantum
set -gx BAT_THEME Catppuccin-macchiato
set -x STARSHIP_CONFIG ~/.config/starship/starship.toml 
set -Ux ZELLIJ_AUTO_EXIT true

set -Ux FZF_DEFAULT_OPTS "\
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

set -l source_dir (dirname (status -f))

source $source_dir/env.fish
source $source_dir/aliases.fish
source $source_dir/git.fish


source (brew --prefix)/opt/asdf/libexec/asdf.fish

theme_gruvbox "dark" "hard"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/danilo/google-cloud-sdk/path.fish.inc' ]
     source '/home/danilo/google-cloud-sdk/path.fish.inc'
end
