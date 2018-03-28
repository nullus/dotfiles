function __aws_profile_prompt -d "Format AWS profile for prompt"
    if not set -q AWS_PROFILE
        return 1
    end

    set -l normal (set_color normal)
    set -l aws_prompt_colour (set_color normal)
    set -l aws_profile_colour_var __aws_profile_colour_$AWS_PROFILE
    set -l aws_profile_colour (
        if set -q $aws_profile_colour_var
            set_color $$aws_profile_colour_var
        else
            # Default indicates danger
            set_color red
        end
    )
    
    echo -n -s " " $aws_prompt_colour "[" $aws_profile_colour $AWS_PROFILE $aws_prompt_colour "]"
end

