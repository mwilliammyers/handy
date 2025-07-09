function esource --description 'source with extra powers'
	for f in $argv
		for line in (grep -vE '^\s*($|#)' $argv)
			set key_val (string split "=" -- $line)
			set -x $key_val[1] $key_val[2]
		end
	end
end
