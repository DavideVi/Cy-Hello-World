
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.1.0"
    }
  }

  # Cannot use variables here, config must come from 
  # the `terraform init` command
  # Could hard-code but would rather not have the 
  # entire Internet know where my states are kept
  backend "s3" {}
}

