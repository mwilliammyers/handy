function speedtest -d "measure internet speed"
	curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py \
		| python -
end
