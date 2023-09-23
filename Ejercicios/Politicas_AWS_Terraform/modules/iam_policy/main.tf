# Create a new IAM policy document
data "aws_iam_policy_document" "ec2_permissions" {
  statement {
    sid       = "1psEC2"
    effect    = "Allow"
    actions   = ["ec2:*"]
    resources = ["*"]
  }
  statement {
    sid       = "2psEC2"
    effect    = "Deny"
    actions   = ["ec2:TerminateInstances"]
    resources = ["*"]
  }
  statement {
    sid       = "3psEC2"
    effect    = "Allow"
    actions   = ["iam:ChangePassword"]
    resources = ["arn:aws:iam::318539273132:user/EC2User"]
  }
}

# Create a new IAM policy
resource "aws_iam_policy" "ec2_permissions_policy" {
  name   = "EC2PermissionsPolicy"
  policy = data.aws_iam_policy_document.ec2_permissions.json
}

# Add the policy to the group
resource "aws_iam_group_policy_attachment" "ec2_permissions_attachment" {
  group      = aws_iam_group_ec2_full_access_group_name
  policy_arn = aws_iam_policy.ec2_permissions_policy.arn
}