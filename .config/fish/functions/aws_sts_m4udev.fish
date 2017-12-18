function aws_sts_m4udev --description 'Create an AWS security token for m4udev/platformteam'
	aws_sts_assume_role arn:aws:iam::973953763841:role/platformteam
end
