
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

provider "aws" {}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/../function/function.py"
  output_path = "./payload.zip"
}

resource "aws_lambda_function" "test_lambda" {
  filename      = "payload.zip"
  function_name = "cy_hello_world"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "function.lambda_handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.10"
}