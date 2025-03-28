provider "aws" {
  region = "eu-west-1"
}

module "oam_sink" {
  source = "../../modules/sink"

  # override default name
  name = "sink"
}
