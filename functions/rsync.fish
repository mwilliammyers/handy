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
   
    # TODO: add --protect-args option?
    # TODO: add --fake-super option?
   
    git \
        -C $src_dir \
        ls-files \
        --ignore \
        --exclude-standard \
        --others \
        --directory \
        ^/dev/null \
    | command rsync \
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
        --exclude=.DS_Store \
        --exclude-from=- \
        $argv
end
