terraform {
  backend "s3" {
    bucket         = "statebucket0"
    key            = "statebucket0/vpc1-tf"
    region         = "us-east-1"
    encrypt        = true
  }
}
