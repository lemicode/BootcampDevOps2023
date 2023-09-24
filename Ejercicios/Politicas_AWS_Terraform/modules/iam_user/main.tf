# Create a new IAM user
resource "aws_iam_user" "ec2_user" {
  name = "EC2User"
}

resource "aws_iam_user_login_profile" "ec2_user_login_profile" {
  user                    = aws_iam_user.ec2_user.name
  password_length         = 16
  password_reset_required = true
}

# Add the user to the group
resource "aws_iam_user_group_membership" "ec2_user_membership" {
  user = aws_iam_user.ec2_user.name

  groups = [
    var.iam_group_name
  ]
}