terraform {
 backend "remote" {
    organization = "alleaffengaffen"

    workspaces {
      name = "cucumber"
    }
  }
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.47"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.10"
    }
  }
}