function aws_sts_m4ustg --description 'Create an AWS security token for m4ustg/platformteam'
	aws_sts_assume_role arn:aws:iam::675008132621:role/platformteam
end
