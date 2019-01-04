function ffprobe
    command ffprobe -v error -print_format json -show_format -show_streams -hide_banner $argv
end
