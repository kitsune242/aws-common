resource "aws_sns_topic" "this" {
  name = var.topic_name
  tags = var.tags
}

resource "aws_sns_topic_policy" "default" {
  arn = aws_sns_topic.this.arn

  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect = "Allow"

    actions = [
      "SNS:Publish",
    ]

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    resources = [
      aws_sns_topic.this.arn,
    ]
  }
}
