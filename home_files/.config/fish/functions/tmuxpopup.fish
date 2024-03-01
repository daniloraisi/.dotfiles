function tmuxpopup -d "toggle tmux popup window"
	set width '60%'
	set height '60%'
	set session (tmux display-message -p -F "#{session_name}")

	if contains "popup" $session
		tmux detach-client
	else
		tmux popup -d "#{pane_current_path}" -xR -yP -w$width -h$height -E "tmux attach -t popup || tmux new -s popup"
	end
end
