function cleanup -d "cleanup unecessary files & directories"
	rm -rf ~/.DS_Store ~/.subversion/ ~/.lesshst ~/.ansible .ansible_galaxy \
		~/.bash_profile ~/.bashrc ~/.bash_history ~/.zshrc \
		~/.vim ~/.viminfo ~/.rnd ~/.node-gyp ~/.node_repl_history \
		~/.python_history ~/.tox ~/.ipython ~/.pylint.d \
		~/.atom ~/.gi_list ~/.matplotlib ~/.ipython ~/.jupyter ~/.python27_compiled \
		~/.sync-settings.cache ~/.babel.json ~/.ipynb_checkpoints ~/.cups \
		~/.ansible_galaxy ~/.serverless/ ~/.gsutil/ ~/.plotly/ ~/.cufflinks/
	 # get around fish complaining about empty shell glob matches
	 for f in ~/.v8flags*
		 rm -f $f
	 end
end