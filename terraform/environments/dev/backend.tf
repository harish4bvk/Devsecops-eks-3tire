terraform {
  backend "s3" {
    bucket = "harish-terraform-state-devsecops-eks"
    key    = "dev/terraform.tfstate"
    region = "ap-south-1"

    use_lockfile = true
  }
}