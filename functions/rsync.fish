function rsync --description rsync
    if not status --is-interactive
        command rsync $argv
        return
    end

    set src_dir './'
    for arg in $argv
        if test -d $arg
            set src_dir $arg
            # the source directory will always be before the destination
            break
        end
    end
    
    # --no-inc-recursive \
    set args "\
        --recursive \
        --links \
        --hard-links \
        --times \
        --perms \
        --xattrs \
        --devices \
        --specials \
        --update \
        --partial \
        --info=progress2 \
        --human-readable \
        --exclude=.DS_Store \
        --exclude-from=- \
        $argv \
    "

    for file in ~/.gitignore ~/.config/git/ignore
        if test -f $file
            set args " --exclude-from=$file $args"
        end
    end

    git -C $src_dir ls-files -io --exclude-standard --directory ^/dev/null \
        | eval command rsync $args
end
