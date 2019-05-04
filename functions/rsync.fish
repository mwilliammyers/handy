function rsync --description rsync
    set exclude '.DS_Store'
    for arg in $argv
        if test -d $arg
            set result (git -C $arg ls-files --ignore --exclude-standard --others --directory ^/dev/null)
            set exclude "$exclude "$result
            # the source directory will always be before the destination
            break
        end
    end

    # TODO: add --protect-args option?
    # TODO: add --fake-super option?
    command  rsync \
        --recursive \
        --links \
        --hard-links \
        --times \
        --owner \
        --group \
        --acls \
        --perms \
        --xattrs \
        --devices \
        --specials \
        --update \
        --partial \
        --no-inc-recursive \
        --info=progress2 \
        --human-readable \
        --exclude-from=$HOME/.config/git/ignore \
        --exclude=$exclude \
        $argv
end
