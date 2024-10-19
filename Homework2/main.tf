provider aws {
	region = "us-east-2"
}

# Creating Bastion-key

resource "aws_key_pair" "deployer" {
  key_name   = "Bastion-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}

# Creating public key 

resource "aws_key_pair" "deployer2" {
key_name = "deployer-key"
public_key = file("~/.ssh/id_rsa.pub")
}

# Creating S3 buckets : kaizen-annaz and kaizen-prefix

resource "aws_s3_bucket" "test2" {
  bucket = "kaizen-annaz"
}

resource "aws_s3_bucket" "test1" {
  bucket_prefix = "kaizen-"
  force_destroy = true
}

# Importing buckets kaizen-test-1 and kaizen-test-2

# terraform import aws_s3_bucket.test3 kaizen-test-1
# terraform import aws_s3_bucket.test4 kaizen-test-2

resource "aws_s3_bucket" "test3" {
  bucket = "kaizen-test-1"
}

resource "aws_s3_bucket" "test4" {
  bucket = "kaizen-test-2"
}

# Creating users : jenny, rose, lisa, jisoo with for_each

resource "aws_iam_user" "user1" {
  for_each = toset(["jenny", "rose", "lisa", "jisoo"])
  name = each.value
}

# Creating group : blackpink

resource "aws_iam_group" "groupBP" {
  name = "blackpink"
}

# Adding users : jenny, rose, lisa, jisoo to group blackpink

resource "aws_iam_group_membership" "bp" {
  name = "t-group"

  users = [
    for i in aws_iam_user.user1 : i.name
  ]

  group = aws_iam_group.groupBP.name
}