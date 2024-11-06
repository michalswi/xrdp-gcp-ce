
provider "google" {}

provider "tls" {}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "=4.85.0"
      # version = "~>4.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.4.0"
      # version = "~>3.0"
    }
  }
  # terraform version
  required_version = "~>1.5.0"
}
