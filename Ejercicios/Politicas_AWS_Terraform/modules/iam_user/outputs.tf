# Print the encrypted password
output password {
  value       = "${aws_iam_user_login_profile.ec2_user_login_profile.encrypted_password}"
  description = "The encrypted password for the user"
}