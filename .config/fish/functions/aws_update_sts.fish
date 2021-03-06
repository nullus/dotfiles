function aws_update_sts --description 'Create session token using MFA'
    # Requires a basic AWS configuration containing:
    # - mfa_serial in [default] section;
    # - [default] credentials (authentication account)
    if not _aws_sts_expired
        # Don't regenerate token if it's still valid
        return 0
    end
    set TMPFILE (mktemp)
    or begin
        echo "Failed to create temporary credential file" >&2
        return 1
    end
    read -P 'Enter MFA code: ' token_code
    aws sts --output json --profile default get-session-token --serial-number (aws configure get default.mfa_serial) --token-code "$token_code" > $TMPFILE
    or begin
        echo "Failed to create sts session token" >&2
        return 1
    end
    aws configure set profile.token.aws_access_key_id (jq -r .Credentials.AccessKeyId $TMPFILE)
    aws configure set profile.token.aws_secret_access_key (jq -r .Credentials.SecretAccessKey $TMPFILE)
    aws configure set profile.token.aws_session_token (jq -r .Credentials.SessionToken $TMPFILE)
    set -Ux __aws_sts_expiration (jq -r '.Credentials.Expiration|strptime("%Y-%m-%dT%H:%M:%S+00:00")|mktime' $TMPFILE) 
    rm $TMPFILE
    or begin
       echo "Failed to remove temporary credential file: $TMPFILE" >&2
    end
end
