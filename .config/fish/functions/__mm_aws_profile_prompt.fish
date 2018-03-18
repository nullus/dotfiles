function __mm_aws_profile_prompt -d "Format AWS profile for prompt"
    if not set -q AWS_PROFILE
        return 1
    end

    set -l normal (set_color normal)
    set -l mm_color_prompt (set_color brblack)
    set -l mm_color_aws_profile (switch "$AWS_PROFILE"
            case m4udev
                echo (set_color brgreen)
            case m4uqa
                echo (set_color brblue)
            case m4ustg
                echo (set_color bryellow)
            case '*'
                echo (set_color brred)
        end)

    echo -n -s " " $mm_color_prompt "[" $mm_color_aws_profile $AWS_PROFILE $mm_color_prompt "]"
end

