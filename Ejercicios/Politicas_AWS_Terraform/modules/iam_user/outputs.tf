output "password" {
  value       = aws_iam_user_login_profile.ec2_user_login_profile.password
  description = "Example"
}
