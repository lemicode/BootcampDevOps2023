# Create a new IAM group
resource "aws_iam_group" "ec2_full_access_group" {
  name = "ec2_full_access_group"
}
