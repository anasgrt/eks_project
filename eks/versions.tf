terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.27.0"
    }

    # random = {
    #   source  = "hashicorp/random"
    #   version = "~> 3.5.1"
    # }

    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.12.1"
    }
  }


  # backend "s3" {
  #   region         = "eu-west-1"
  #   bucket         = "terraform-statefiles-kabisa-playground"
  #   dynamodb_table = "kabisa-terraform-lockfiles"
  #   key            = "kabisa-playground/education-eks.tfstate"
  #   encrypt        = true
  #   role_arn       = "arn:aws:iam::820116308106:role/admin"
  #   session_name   = "terraform"
  # }
}