# Painless Infrastructure

Get the benefits of serverless architecture without its drawbacks.

## Requirements

* Docker
* An AWS account
* Your AWS credentials in ~/.aws/credentials. See [instructions](https://docs.aws.amazon.com/cli/latest/userguide/cli-config-files.html)
* Basic knowledge of Docker
* Basic knowledge of Terraform

## Basic Usage

1. Dockerize your app
1. Push your docker app to Docker Hub
1. Create the following terraform file in your project. Name it `deploy.tf`

  ```
  module "painless_infra" {
    source "/painless_infra"

    app_image = "<Docker Hub app to your instance>"
  }

  ```

1. Run the following command

  ``` bash
  docker run -it --rm -v ~/.aws/:/root/.aws arturop/painless_infra
  ```

1. Get public IP of your app

  ```
  docker run -it --rm -v ~/.aws/:/root/.aws arturop/painless_infra ./get_public_ip.sh
  ```

1. Open your browser and navigate to the printed public IP
