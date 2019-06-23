function ffprobe
    command ffprobe \
        -v error \
        -hide_banner \
        -print_format json \
        -show_entries stream:format:stream_disposition=:stream_tags=:format_tags= \
        $argv
end
