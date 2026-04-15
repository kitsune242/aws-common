# OLI Infrastructure Modules

This directory contains reusable Terraform modules for the OneLab Insights platform.

## Available Modules

- **s3_bucket**: Standardized S3 bucket with encryption and public access blocks.
- **sns_topic**: SNS topics for event-driven notifications.
- **lambda_function**: Python Lambda functions with IAM roles and SNS triggers.
- **tf_backend**: Infrastructure for remote state management.

## Usage

Reference these modules using remote git sources:

```hcl
module "example" {
  source = "git::https://github.com/roche-oli/oli-poc-common.git//infra/modules/s3_bucket?ref=v1.0.0"
  # ... inputs
}
```
