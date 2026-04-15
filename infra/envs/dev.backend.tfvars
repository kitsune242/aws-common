bucket       = "oli-terraform-state-us-east-1-dev"
region       = "us-east-1"
use_lockfile = true
encrypt      = true
# key is NOT set here — it is computed dynamically by the CI/CD workflow
# (inputs.path + "/terraform.tfstate") or must be specified explicitly for local dev
