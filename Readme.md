# Painless Infrastructure

Get the benefits of serverless architecture without its drawbacks.

## Requirements

* Docker
* An AWS account
* Your AWS credentials in ~/.aws/credentials. See [instructions](https://docs.aws.amazon.com/cli/latest/userguide/cli-config-files.html)

## Basic Usage

1. Dockerize your app
1. Push your docker app to Docker Hub
1. Create the following terraform file in your project. Name it `deploy.tf`

  ```
  provider "aws" {
    region = "us-east-1"
    profile = "<AWS credentials you want to use. See ~/.aws/credentials>"
  }

  module "painless_infra" {
    source = "/painless-infra"

    environment_name = "<A Name used for tagging resources>"
    app_image = "<Docker Hub app to your instance>"
    subdomain = "<Subdomain>"
  }

  output "domain_name" {
    value = "${module.painless_infra.domain_name}"
  }
  ```

1. Run the following commands

  ``` bash
  docker run --rm arturop/painless-infra init_infra
  docker run -it --rm --volume ~/.aws/:/root/.aws --volume "$(pwd)":/app arturop/painless-infra deploy
  ```

1. Get public IP of your app

  ```
  docker run -it --rm -v ~/.aws/:/root/.aws arturop/painless-infra get_domain
  ```

1. Open your browser and navigate to the printed domain
