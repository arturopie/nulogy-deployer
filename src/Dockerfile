# IF YOU CHANGE THIS FILE, PLEASE UPDATE "PAINLESS_INFRA_VERSION" in versions.sh
FROM alpine:latest
MAINTAINER "Arturo Pie"

RUN apk add --update \
  bash \
  curl \
  && rm -rf /var/cache/apk/*

ENV TERRAFORM_VERSION="0.11.2"

RUN cd /usr/local/bin && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

ENV TF_PLUGIN_CACHE_DIR="/root/.terraform.d/plugin-cache"
ENV TF_INPUT="0"

# Downloads the Terraform AWS Provider Plugin
RUN mkdir /init && cd /init && echo 'provider "aws" {region = "us-east-1" } #1.6.0' > init.tf && terraform init && rm -rf /init

COPY . /painless-infra

RUN cp -rs /painless-infra/utils/*  /usr/local/bin/

WORKDIR /painless-infra
