terraform {
  backend "s3" {
    bucket         = "my-bucket-arr-20"
    key            = "terraform.tfstate2"
    region         = "us-east-1"
    encrypt        = true
  }
}