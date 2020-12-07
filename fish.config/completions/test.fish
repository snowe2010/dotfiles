function get_foo_args
    # Here are our possible comma-separated values.
    set choices happy green dragon

    # Get what the user has typed so far as the token under the cursor.
    # For example, this might be "--stuff=abc,def"
    set token (commandline -ct)
    
    # We don't know if the user used a space or = separator.
    # Split about =, and take the last part.
    set input (string split = -- $token)[-1]
    
    # Get the items that the user has written so far, discarding the last item.
    # That is, if the user wrote "happy,green,dr<tab>" then we want to discard the 'dr'.
    set input (string split ',' -- $input)
    set -e input[-1]
    set input (string join ',' -- $input)

    # Now propose every possible choice, trimming leading and trailing commas.
    for choice in $choices
        echo "$input,$choice" | string trim --chars ',' 
    end
end

complete -c foo --exclusive --long-option stuff --arguments "(get_foo_args)"