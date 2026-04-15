variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "handler" {
  description = "The function handler"
  type        = string
  default     = "index.lambda_handler"
}

variable "runtime" {
  description = "The runtime for the Lambda function"
  type        = string
  default     = "python3.12"
}

variable "timeout" {
  description = "The amount of time the Lambda function has to run (seconds)"
  type        = number
  default     = 60
}

variable "memory_size" {
  description = "The amount of memory available to the Lambda function (MB)"
  type        = number
  default     = 256
}

variable "filename" {
  description = "The path to the function's deployment package"
  type        = string
}

variable "environment_variables" {
  description = "A map of environment variables to pass to the function"
  type        = map(string)
  default     = {}
}

variable "sns_topic_subscription_arn" {
  description = "The ARN of the SNS topic to subscribe to"
  type        = string
  default     = null
}

variable "iam_policy_json" {
  description = "The IAM policy document for the Lambda role"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the function"
  type        = map(string)
  default     = {}
}
