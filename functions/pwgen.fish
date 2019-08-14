function pwgen -d "Generate a password"
	argparse --name=pwgen 'h/help' 'N/num-passwords=' 'y/symbols' -- $argv
	or return

	if set --query _flag_help
		printf "Usage: pwgen [OPTIONS] [PW_LENGTH]\n\n"
		printf "Options:\n"
		printf "  -h/--help               Prints help and exits.\n"
		printf "  -N/--num-passwords=NUM  Generate [NUM] passwords.\n"
		printf "  -y/--symbols            Include at least one special character in the password."

		return 0
	end

	set -l pw_length 20
	test -n $argv[1]; and set -l pw_length $argv[1]

	set -q _flag_N; or set -l _flag_N 1

	set -l allowed_chars 'a-zA-Z0-9'
	# or @$!%*#?&'
	set -l symbols '@#$%^&*()_+{}|:<>?='
	set -q _flag_y; and set -l allowed_chars $symbols$allowed_chars

	set -x LC_ALL C
	cat /dev/urandom | tr -dc $allowed_chars | fold -w $pw_length | head -n $_flag_N
end
