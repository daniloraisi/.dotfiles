current_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
dotfiles_source="${current_dir}/../home_files"

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
