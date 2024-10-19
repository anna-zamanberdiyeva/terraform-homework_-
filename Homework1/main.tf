resource "aws_iam_user" "user1" {
  for_each = toset(["jenny", "rose", "lisa", "jisoo"])
  name = each.value
}

resource "aws_iam_user" "user2" { 
  for_each = toset(["jihyo", "sana", "momo", "dahyun"])
  name = each.value
}

resource "aws_iam_group" "group1" {
  name = "blackpink"
}

resource "aws_iam_group" "group2" {
  name = "twice"
}

resource "aws_iam_group_membership" "bp" {
  name = "t-group1"

  users = [
    for i in aws_iam_user.user1 : i.name
  ]

  group = aws_iam_group.group1.name
}

resource "aws_iam_group_membership" "t" {
  name = "t-group2"

  users = [
    for i in aws_iam_user.user2 : i.name
  ]

  group = aws_iam_group.group2.name
}

# Import users miyeon and mina

resource "aws_iam_user" "user3" {
  name = "miyeon"
}

resource "aws_iam_user" "user4" {
  name = "mina"
}

# Add users miyeon and mina to groups blackpink and twice

resource "aws_iam_group_membership" "bp3" {
  name = "t-group3"

  users = [
    aws_iam_user.user3.name
  ]

  group = aws_iam_group.group1.name
}

resource "aws_iam_group_membership" "t4" {
  name = "t-group4"

  users = [
    aws_iam_user.user4.name
  ]

  group = aws_iam_group.group2.name
}