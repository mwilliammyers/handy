function ffx265
    for path in $argv
        set -l dir (dirname "$path")
        set -l name (basename "$path")
        
        # TODO: be smarter about this
        set -l ext (string split '.' "$name")[-1]
       
        # TODO: should we transcode to mp4 at the same time, or leave it as is?
        set -l out_path (string replace "$ext" "transcoded.mp4" "$path")
        
        # TODO: use hevc_videotoolbox on macOS when available
        # TODO: use hevc_nvenc when available
        ffmpeg \
            -i "$path" \
            -c:v libx265 -preset medium \
            -c:a copy \
            -c:s copy -c:d copy -c:t copy \
            "$out_path"
    end
end
