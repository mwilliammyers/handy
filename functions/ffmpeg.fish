function ffmpeg -d "Run ffmpeg"
	if command -v ffmpeg
		command ffmpeg -hide_banner $argv
	else
		docker run -it --rm -v $PWD/:/tmp/ -w /tmp \
			jrottenberg/ffmpeg:4.0-alpine -hide_banner $argv
	end
end
