function aws_sts_assume_role --description 'Create an AWS security token for a given role, with MFA'
	if test (count $argv) -lt 1
		echo 'TODO: balls'
		return 1
	end
	read -P 'Enter MFA code: ' token_code
	eval (aws sts assume-role --profile m4uinf --role-arn $argv[1] --role-session-name terraform --serial-number arn:aws:iam::183839469016:mfa/dylan --token-code $token_code | jq -r '.Credentials|"set -x AWS_ACCESS_KEY_ID " + .AccessKeyId + ";\n" + "set -x AWS_SECRET_ACCESS_KEY " + .SecretAccessKey + ";\n" + "set -x AWS_SESSION_TOKEN " + .SessionToken')
end
