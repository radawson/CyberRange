provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "${pathexpand("~/.aws/credentials")}"
}

module "staging-state" {
  source      = "../../modules/state"
  environment = "${var.environment}"
}

terraform {
  backend "s3" {
    bucket  = "cyberrange.clockworx.tech"
//    key     = "london/secdevops-cuse.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

module "range-infra" {
  source      = "../../modules/infrastructure"
  environment = var.environment
  cidr = var.cidr
}
