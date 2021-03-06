# This just sets the aws provider default region to us-east-1
provider "aws" {
  region = "us-east-1"
}

# This defines how our terraform state is stored. Terraform state
# is a json file that tracks the identifiers and state of our resources
# this enables terraform to perform state transitions and only change resources
# which have actually changed. To run terraform apply - we need state.
terraform {
  backend "s3" {
    bucket = "my-omoterraform-state-bucket"
    key    = "my-blog.com.tfstate"
    region = "us-east-1"
  }
}

# Here's our bucket configuration. Pretty simple really
# It has a name, an acl of "public-read", a public bucket policy
# and a website configuration.
resource "aws_s3_bucket" "b" {
  bucket = "edewe-gatsby-blog.com"
  acl    = "public-read"

  policy = file("policy.json")

  website {
    index_document = "index.html"
  }
}