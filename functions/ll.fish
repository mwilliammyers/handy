function ll --description "List contents of directory using long format"
	exa --long --extended --modified --git --time-style=iso $argv
end

