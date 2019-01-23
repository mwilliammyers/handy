function rsync --description rsync
    set exclude ''
    if test -e $PWD/.gitignore
        set exclude "--exclude-from=.gitignore"
    end

    command  rsync -ahuL --partial --info=progress2 --exclude=.git --exclude='.DS_Store' $exclude $argv
end
