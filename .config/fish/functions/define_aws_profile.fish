function define_aws_profile -d "Define configuration for AWS prompt colouration" --argument-names profile_name colour
    if not set -q profile_name
        echo "USAGE" >&2
        return 1
    end
    if set -q colour
        set -U __aws_profile_colour_{$profile_name} $colour
    end
    alias $profile_name "set -gx AWS_PROFILE $profile_name"
end