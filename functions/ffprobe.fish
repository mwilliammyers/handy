function ffprobe -d "Run ffprobe"
	argparse --name='ffprobe' 'h/help' -- $argv

	set -q _flag_help
	and command ffprobe --help $argv
	and return 0

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
		else
			set -a ffprobe_args $arg
		end
	end

	printf "Running ffprobe, this could take a while...\n\n" 1>&2

	set -l result

	if set -q dirs[1]
		set -a result (fd -t f . $dirs -x ffprobe $ffprobe_args)
	end

	for file in $files
		set -a result (command ffprobe $ffprobe_args "$file")
	end

	echo "$result" | jq -s '. | del(.[].programs)'
end
