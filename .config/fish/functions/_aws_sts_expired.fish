function _aws_sts_expired --description "Test if AWS STS session token has expired"
    test ! "$__aws_sts_expiration" -o "$__aws_sts_expiration" -le (date +%s)
end
