function av-rename
    for vid in $argv
        set -l info (command ffprobe \
            -hide_banner \
            -v error \
            -of csv=p=0 \
            -show_entries stream=codec_name,height \
            $vid \
            | string split ',')
        
        # set -l audio_codec $info[1]
        
        set -l video_codec_num $info[1]
        if test -n "$video_codec_num"
            set video_codec_num (string trim -c h "$video_codec_num")
        end

        set -l video_height $info[2]
        if test -n "$video_height"
            set -l res (math -- "abs(1080 - $video_height)")

            if test $res -lt 50
                set video_height 1080
            end
        end

        # TODO: be smarter about this
        set -l ext (string split '.' $vid)[-1]
        
        set -l new_name "$vid" 

        if ! string match -iq -- "*$video_height*" "$vid"
            set new_name (string replace "$ext" "$video_height"p".$ext" "$new_name")
        end
        
        if ! string match -iq -- "*$video_codec_num*" "$vid"
            set new_name (string replace "$ext" "x$video_codec_num.$ext" "$new_name")
        end
        
        # TODO: support this as an option
        # set new_name (string lower "$new_name")
        # set new_name (string replace -ar "\s+" "_" "$new_name")
        
        if test -n "$new_name"
            # TODO: support dry run
            # echo "$vid -> $new_name"
            
            mv -v "$vid" "$new_name"
        end
    
        # TODO: call this once at end
        # supper ren -a move "$new_name"
    end
end
