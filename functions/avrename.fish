function avrename
    
    for video_path in $argv
        # if ! test -f "$video_path"
        #     continue
        # end

        set -l video_dir (dirname "$video_path")
        set -l video_name (basename "$video_path")

        # TODO: figure out how to incorperate supper
        # supper ren -a move "$video_path"
       
        # TODO: handle autio too
        set -l info (command ffprobe \
            -hide_banner \
            -v error \
            -of csv=p=0 \
            -select_streams v \
            -show_entries stream=codec_name,height \
            $video_path \
            | string split ',')
       
        if test $status -ne 0
            # TODO: should we attempt to rename it anyway?
            continue
        end

        # supper and/or old versions of macOS are stupid...
        set new_name (string replace "&#39;" "'" "$video_name")
        
        # TODO: support these as an option
        # set new_name (string lower "$video_name")
        # set new_name (string replace -ar "\s+" "_" "$new_name")
        
        # TODO: be smarter about this
        set -l ext (string split '.' $new_name)[-1]
        
        set -l video_height $info[2]
        if test -n "$video_height"
            # TODO: also 576?
            # check some resolutions in order(ish) of how common they are
            for res in 1080 720 2160 900 540 1440 360 1152 2880 1620 4320 4608 8640
                if test (math -- "abs($res - $video_height)") -lt 50
                    set video_height "$res"
                    break
                end
            end
            
            # TODO: don't assume they are already in the correct order
            if ! string match -iq -- "*$video_height*" "$new_name"
                set new_name (string replace "$ext" "$video_height"p".$ext" "$new_name")
            end
        end
        
        set -l raw_video_codec $info[1]
        if test -n "$raw_video_codec"
            set video_codec (string replace -i "hevc" "x265" "$raw_video_codec")
            
            set video_codec_num (string replace -r '\D' '' "$video_codec")
            
            # TODO: don't assume they are already in the correct order
            if ! string match -iqr -- "$video_codec_num|$raw_video_codec" "$new_name"
                set new_name (string replace "$ext" "$video_codec.$ext" "$new_name")
            end
        end
        # TODO: is this safe to assume?
        set new_name (string replace -i "h26" "x26" "$new_name")

        
        # TODO: support dry run
        # echo "$video_path -> $video_dir/$new_name"
        
        mv -v "$video_path" "$video_dir/$new_name"
    end
end
