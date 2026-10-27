terraform {
  backend "s3" {
    bucket       = "eks-tfstate-2"
    key          = "AWS-EKS/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
  }
}
