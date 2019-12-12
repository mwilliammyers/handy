function ffprobe -d "Run ffprobe"
	# -show_entries "format=filename,duration,format_name,size:stream=codec_name,height,width"
	set -l ffprobe_args \
		-v error \
		-hide_banner \
		-of json \
		-show_entries "stream:format:stream_disposition=:stream_tags=:format_tags="

	set -l dirs
	set -l files

	for arg in $argv
		if test -d $arg
			set -a dirs $arg
		else if test -f $arg
			set -a files $arg
		# TODO: handle $arg looking like an opt, e.g. `-v` without `^/dev/null`
		# Don't use argparse because it gets confused with unknown opts
		else if string match -qir '-h|--help' "$arg" ^/dev/null
			command ffprobe $argv
			and return 0
		else
			set -a ffprobe_args $arg
		end
	end


	# FIXME: for some reason this does not work
	# string join0 "$files" | command xargs -P8 -0 -I'#' ffprobe '#' $ffprobe_args

	# TODO: parallelize this with xargs
	# do the files first so the user gets feedback faster
	for file in $files
		__ffprobe $ffprobe_args "$file"
	end

	if set -q dirs[1]
		for file in fd -t f . $dirs
			__ffprobe $ffprobe_args
		end
	end
end
	
function __ffprobe
	if command -v ffprobe 
		command ffprobe $argv
	else
		docker run -it --rm -v $PWD/:/tmp/ -w /tmp --entrypoint=ffprobe \
			jrottenberg/ffmpeg:4.0-alpine $argv
	end
end
