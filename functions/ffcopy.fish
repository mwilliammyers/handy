function ffcopy
    for path in $argv
        set -l dir (dirname "$path")
        set -l name (basename "$path")
        
        # TODO: be smarter about this
        set -l ext (string split '.' "$name")[-1]
       
        # TODO: should we transcode to mp4 at the same time, or leave it as is?
        set -l out_path (string replace "$ext" "mp4" "$path")
    
        ffmpeg -i "$path" -c:v copy -c:a copy -c:s copy -c:d copy -c:t copy "$out_path"
    end
end
