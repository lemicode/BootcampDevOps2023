# Create a new IAM group
module "iam_group" {
  source = "./modules/iam_group"
}

# Create a new IAM policy
module "iam_policy" {
  source = "./modules/iam_policy"
}

# Create a new IAM user
module "iam_user" {
  source = "./modules/iam_user"
}
