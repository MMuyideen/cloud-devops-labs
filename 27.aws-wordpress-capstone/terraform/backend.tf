terraform {
  backend "s3" {
    bucket = "deens3backend"
    key    = "terraform"
    region = "us-west-1"
  }
}