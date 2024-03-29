function pwgen -d "Generate a secure password"
    set min_pw_length 8
    set default_pw_length 20
    set default_num_pw 1
    set default_allowed_chars 'a-zA-Z0-9'
    set default_symbols '@#$%^&*()_+{}|:<>?=' # or just @$!%*#?&' ?
    set min_block_size 128
    set num_blocks_scale 2.1 # empirical rough estimate
    set block_size_scale 1.3 # empirical rough estimate

    argparse --name=pwgen 'h/help' 'N/num-passwords=!_validate_int --min 1' 's/symbols=' -- $argv
    or return

    if set -q _flag_help
        echo "Usage: pwgen [OPTIONS] [PW_LENGTH]"
        echo ""
        echo "Options:"
        echo "  -h/--help               Prints help and exits."
        echo "  -N/--num-passwords=NUM  Generate [NUM] passwords (default: $default_num_pw)."
        # This cannot use printf
        echo "  -s/--symbols=STRING     Include specified symbols in addition to alphanumeric characters (default: $default_symbols)."

        return 0
    end

    set pw_length (math $argv[1] + 1)
    test -z $pw_length
    and set pw_length $default_pw_length
    if test $pw_length -lt $min_pw_length
        echo "`PW_LENGTH` must be at least 8" >&2
        return 1
    end

    set num_pw $_flag_N
    test -z $num_pw
    and set num_pw $default_num_pw

    set symbols $_flag_s
    test -z $symbols
    and set symbols $default_symbols
    # TODO: allow setting characters explicitly?
    set allowed_chars $symbols$default_allowed_chars

    set num_blocks (math "round($num_blocks_scale * $num_pw)")

    set block_size (math "round($block_size_scale * $pw_length)")
    test $block_size -lt $min_block_size
    and set block_size $min_block_size
    # nearest power of 2
    set block_size (math "pow(2, ceil(log($block_size) / log(2)))")

    # `cat` was causing issues for some reason, so use `dd`
    set -x LC_ALL C
    dd if=/dev/urandom bs=$block_size count=$num_blocks 2>/dev/null \
        | tr -dc $allowed_chars \
        | fold -w (math "$pw_length - 1") \
        | head -n $num_pw
end
