function ll --description "List contents of directory using long format"
	exa --long --group --modified --git --time-style=iso $argv
end

