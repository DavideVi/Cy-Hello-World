
# Vars =========================================================================

# Not providing a default so that there's no 
# accidental deployments in the wrong place
variable "branch" {}

# Config =======================================================================

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

# Lambda =======================================================================

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

resource "aws_iam_role" "hello_world_lambda_role" {
  name               = "${var.branch}-hello_world_lambda_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/../function/function.py"
  output_path = "./payload.zip"
}

resource "aws_lambda_function" "hello_world_lambda" {
  filename      = "payload.zip"
  function_name = "${var.branch}-cy_hello_world"
  role          = aws_iam_role.hello_world_lambda_role.arn
  handler       = "function.lambda_handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.10"
}

# API Gateway ==================================================================

resource "aws_apigatewayv2_api" "hello_world_api" {
  name                       = "hello-world-api"
  protocol_type              = "HTTP"
}

resource "aws_apigatewayv2_integration" "hello_world_integration" {
  api_id           = aws_apigatewayv2_api.hello_world_api.id
  integration_type = "AWS_PROXY"

  connection_type           = "INTERNET"
  description               = "Lambda example"
  integration_method        = "POST"
  integration_uri           = aws_lambda_function.hello_world_lambda.invoke_arn
  passthrough_behavior      = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_route" "hello_world_default_route" {
  api_id = aws_apigatewayv2_api.hello_world_api.id
  route_key = "$default"
  target = "integrations/${aws_apigatewayv2_integration.hello_world_integration.id}"
}

resource "aws_apigatewayv2_stage" "hello_world_stage" {
  api_id = aws_apigatewayv2_api.hello_world_api.id
  name = var.branch
  auto_deploy = true

  default_route_settings {
    detailed_metrics_enabled = true
    logging_level = "INFO"
    throttling_burst_limit = 5000
    throttling_rate_limit = 10000
  }
}

# Outputs ======================================================================

output "api_url" {
  value = aws_apigatewayv2_stage.hello_world_stage.invoke_url
}
