resource "aws_iam_role" "this" {
  name = "${var.function_name}-role"

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

  tags = var.tags
}

resource "aws_iam_role_policy" "this" {
  name   = "${var.function_name}-policy"
  role   = aws_iam_role.this.id
  policy = var.iam_policy_json
}

resource "aws_lambda_function" "this" {
  function_name    = var.function_name
  handler          = var.handler
  runtime          = var.runtime
  filename         = var.filename
  role             = aws_iam_role.this.arn
  source_code_hash = filebase64sha256(var.filename)
  timeout          = var.timeout
  memory_size      = var.memory_size

  dynamic "environment" {
    for_each = length(var.environment_variables) > 0 ? [var.environment_variables] : []
    content {
      variables = environment.value
    }
  }

  tags = var.tags
}

resource "aws_lambda_permission" "sns" {
  count         = var.sns_topic_subscription_arn != null ? 1 : 0
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = var.sns_topic_subscription_arn
}

resource "aws_sns_topic_subscription" "this" {
  count     = var.sns_topic_subscription_arn != null ? 1 : 0
  topic_arn = var.sns_topic_subscription_arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.this.arn
}
