terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.72"
    }
  }
  required_version = ">= 1.9"
}

provider "aws" {
  region = "eu-west-1"
}

module "oam_sink" {
  source = "../.."
}
