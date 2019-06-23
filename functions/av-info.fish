function av-info
    command ffprobe \
        -v error \
        -print_format json \
        -hide_banner \
        -show_entries stream=codec_name,height,width:format= \
        $argv \
        | jq .streams
end
