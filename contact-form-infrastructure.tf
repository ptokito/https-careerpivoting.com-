# Contact Form Infrastructure for CareerPivoting.com

# Lambda function for handling contact form submissions
resource "aws_lambda_function" "contact_form" {
  filename         = "contact-form-lambda.zip"
  function_name    = "careerpivoting-contact-form"
  role            = aws_iam_role.lambda_role.arn
  handler         = "contact-form-lambda.handler"
  runtime         = "nodejs18.x"
  timeout         = 30
  memory_size     = 128

  environment {
    variables = {
      NODE_ENV = "production"
    }
  }

  tags = {
    Name = "CareerPivoting Contact Form"
    Project = "CareerPivoting"
  }
}

# IAM role for Lambda function
resource "aws_iam_role" "lambda_role" {
  name = "careerpivoting-contact-form-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# IAM policy for Lambda to use SES
resource "aws_iam_role_policy" "lambda_ses_policy" {
  name = "careerpivoting-contact-form-ses-policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ses:SendEmail",
          "ses:SendRawEmail"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

# API Gateway REST API
resource "aws_api_gateway_rest_api" "contact_form" {
  name        = "careerpivoting-contact-form-api"
  description = "API for CareerPivoting contact form submissions"
}

# API Gateway resource
resource "aws_api_gateway_resource" "contact_form" {
  rest_api_id = aws_api_gateway_rest_api.contact_form.id
  parent_id   = aws_api_gateway_rest_api.contact_form.root_resource_id
  path_part   = "contact"
}

# API Gateway method
resource "aws_api_gateway_method" "contact_form_post" {
  rest_api_id   = aws_api_gateway_rest_api.contact_form.id
  resource_id   = aws_api_gateway_resource.contact_form.id
  http_method   = "POST"
  authorization = "NONE"
}

# API Gateway integration with Lambda
resource "aws_api_gateway_integration" "contact_form_lambda" {
  rest_api_id = aws_api_gateway_rest_api.contact_form.id
  resource_id = aws_api_gateway_resource.contact_form.id
  http_method = aws_api_gateway_method.contact_form_post.http_method

  integration_http_method = "POST"
  type                   = "AWS_PROXY"
  uri                    = aws_lambda_function.contact_form.invoke_arn
}

# Lambda permission for API Gateway
resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.contact_form.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.contact_form.execution_arn}/*/*/*"
}

# API Gateway deployment
resource "aws_api_gateway_deployment" "contact_form" {
  depends_on = [
    aws_api_gateway_integration.contact_form_lambda
  ]

  rest_api_id = aws_api_gateway_rest_api.contact_form.id
  stage_name  = "prod"
}

# Output the API endpoint
output "contact_form_api_endpoint" {
  value = "${aws_api_gateway_deployment.contact_form.invoke_url}/contact"
  description = "API endpoint for contact form submissions"
}
