function pwgen -d "Generate a secure password"
	set min_pw_length 8
    set default_pw_length 20
    set default_num_pw 1
    set default_allowed_chars 'a-zA-Z0-9'
    set symbols '@#$%^&*()_+{}|:<>?=' # or just @$!%*#?&' ?
    set min_block_size 128
    set num_blocks_scale 2.1 # empirical rough estimate
    set block_size_scale 1.3 # empirical rough estimate

    argparse --name=pwgen 'h/help' 'N/num-passwords=!_validate_int --min 1' 'y/symbols' 'c/allowed-chars=' -- $argv
    or return

    if set -q _flag_help
        printf "Usage: pwgen [OPTIONS] [PW_LENGTH]\n\n"
        printf "Options:\n"
        printf "  -h/--help                  Prints help and exits.\n"
        printf "  -N/--num-passwords=NUM     Generate [NUM] passwords (default: $default_pw_length).\n"
        printf "  -y/--symbols               Include at least one special character in the password.\n"
        printf "  -c/--allowed-chars=STRING  Only include specified characters (default: $default_allowed_chars)."

        return 0
    end

    set pw_length $argv[1]
    test -z $pw_length
    and set pw_length $default_pw_length
	if test $pw_length -lt $min_pw_length
		echo "`PW_LENGTH` must be at least 8" ^&1
		return 1
	end

    set num_pw $_flag_N
    test -z $num_pw
    and set num_pw $default_num_pw

    if set -q _flag_c
        set allowed_chars $_flag_c
    else
        set allowed_chars $default_allowed_chars

        set -q _flag_y
        and set allowed_chars $symbols$allowed_chars
    end

    set num_blocks (math "round($num_blocks_scale * $num_pw)")

    set block_size (math "round($block_size_scale * $pw_length)")

    test $block_size -lt $min_block_size
    and set block_size $min_block_size

    # nearest power of 2
    set block_size (math "pow(2, ceil(log($block_size) / log(2)))")

    # `cat` was causing issues for some reason, so use `dd`
    set -x LC_ALL C
    dd if=/dev/urandom bs=$block_size count=$num_blocks ^/dev/null \
        | tr -dc $allowed_chars \
        | fold -w (math "$pw_length - 1") \
        | head -n $num_pw
end
