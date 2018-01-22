provider "aws" {
  region = "us-east-1"
  profile = "nulogy-aws-test"
}

module "painless_infra" {
  source = "/painless-infra"

  environment_name = "painless-infra-dummy-app"
  app_image = "arturop/painless-infra-dummy-app:latest"
  subdomain = "hackday-demo"
}

output "domain_name" {
  value = "${module.painless_infra.domain_name}"
}
