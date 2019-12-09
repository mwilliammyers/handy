function esource --description 'source with extra powers'
	for f in $argv
		eval (awk '$0 !~ /(^#|^$)/ {sub(/=\'?/, "=\'"); sub(/^\s*(export)?\s+/, "export "); sub(/\'?;?$/, "\';"); printf $0}' $argv)
	end
end
