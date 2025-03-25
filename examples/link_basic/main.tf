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

module "oam_link" {
  source = "../../modules/link"

  # provide the sink arn, required
  sink_arn = "arn:aws:oam:eu-west-1:123456789012:sink/12345678-aaaa-bbbb-cccc-123456789012"

  # enable forwarding s3 logs
  metric_config = {
    aws_namespaces = {
      s3 = true
    }
  }
}
