terraform {
  backend "s3" {
    # Bucket must exist !
    bucket = "terra-state-max"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}