variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the bucket"
  type        = map(string)
  default     = {}
}

variable "sns_notification_topic_arn" {
  description = "The ARN of an SNS topic for bucket notifications"
  type        = string
  default     = null
}
