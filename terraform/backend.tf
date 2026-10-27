terraform {
  backend "s3" {
    bucket       = "eks-tfstate-2"
    key          = "AWS-EKS/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
