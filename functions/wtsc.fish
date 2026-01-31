function wtsc
	# use execute because the set-upstream-to command does not exit with 0
	wt switch --create $argv[1] \
		--execute "git branch --set-upstream-to=origin/$argv[1]" \
		&& fd -H -t f pyproject.toml --exec sh -c 'cd $(dirname {}) && pwd && uv sync --all-groups'
end
