eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
starship init fish | source
zoxide init fish | source

set -l source_dir (dirname (status -f))

source $source_dir/env.fish
source $source_dir/aliases.fish
source $source_dir/git.fish

if test -d (brew --prefix)"/share/fish/completions"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
end

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

source /home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.fish

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/danilo/google-cloud-sdk/path.fish.inc' ]
    . '/home/danilo/google-cloud-sdk/path.fish.inc'
end