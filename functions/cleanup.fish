function cleanup -d "cleanup unecessary files & directories"
	rm -rfi ~/.subversion/ ~/.lesshst ~/.ansible .ansible_galaxy \
		~/.sh_history ~/.bash_profile ~/.bashrc ~/.bash_history ~/.zshrc \
		~/.vim ~/.viminfo ~/.rnd ~/.node-gyp ~/.node_repl_history \
		~/.python_history ~/.tox ~/.ipython ~/.pylint.d \
		~/.atom ~/.gi_list ~/.matplotlib ~/.ipython ~/.jupyter ~/.python27_compiled \
		~/.sync-settings.cache ~/.babel.json ~/.ipynb_checkpoints ~/.cups \
		~/.ansible_galaxy ~/.serverless/ ~/.plotly/ ~/.cufflinks/
	
	# TODO: figure out how to get gsutil to move these somewhere else
	rm -rf ~/.DS_Store ~/.boto ~/.gsutil/
	
	# get around fish complaining about empty shell glob matches
	for f in ~/.v8flags*
		rm -fi $f
	end

	if test (uname) = Darwin
		if type -q fd
			fd '.DS_Store' ~/ --glob --hidden --no-ignore --type=f --exec-batch rm
		else if type -q find
			find ~/ -name '.DS_Store' -type f -exec rm '{}' \+ 2> /dev/null
		end
	end
end
