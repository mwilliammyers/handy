function venv -d "Create and source a new python3 virtualenv"
	python3 -m venv .venv --clear $argv
	source .venv/bin/activate.fish
end
