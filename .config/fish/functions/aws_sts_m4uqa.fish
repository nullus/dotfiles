function aws_sts_m4uqa --description 'Create an AWS security token for m4uqa/platformteam'
	aws_sts_assume_role arn:aws:iam::629206321152:role/platformteam
end
