function pwgen -a pw_length -d "Generate a password"
	argparse --name=pwgen 'h/help' 'N/num-passwords=' 'y/symbols' -- $argv
	or return

	if set --query _flag_help
		printf "Usage: pwgen [OPTIONS] [PW_LENGTH]\n\n"
		printf "Options:\n"
		printf "  -h/--help               Prints help and exits.\n"
		printf "  -N/--num-passwords=NUM  Generate num passwords.\n"
		printf "  -y/--symbols            Include at least one special character in the password."

		return 0
	end

	set -q pw_length; or set -l pw_length 20
	set -q _flag_N; or set -l _flag_N 1

	set -l allowed_chars 'a-zA-Z0-9'
	set -q _flag_y; and set -l allowed_chars 'a-zA-Z0-9-_!@#$%^&*()_+{}|:<>?='

	set -x LC_ALL C
	# dd if=/dev/urandom bs=512 count=1 2>/dev/null | base64 | cut -c 1-$characters
	cat /dev/urandom | tr -dc $allowed_chars | fold -w $pw_length | head -n $_flag_N
end
