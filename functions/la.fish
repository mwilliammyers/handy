function la --description "List contents of directory, including hidden files in directory using long format"
	exa --all --long --modified --git --time-style=iso $argv
end

