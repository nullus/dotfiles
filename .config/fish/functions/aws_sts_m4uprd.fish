function aws_sts_m4uprd --description 'Create an AWS security token for m4uprd/platformteam'
	aws_sts_assume_role arn:aws:iam::638990390463:role/platformteam
end
