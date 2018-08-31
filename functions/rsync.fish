function rsync --description rsync
	command  rsync -ahuL --partial --info=progress2 --exclude='.DS_Store' $argv
end