# https://github.com/Azure/azure-cli
# https://hub.docker.com/_/microsoft-azure-cli
# see also: https://github.com/microsoft/vscode-dev-containers/blob/master/containers/azure-terraform-0.12/.devcontainer/Dockerfile
FROM mcr.microsoft.com/azure-cli:latest

# check terraform version: https://www.terraform.io/downloads.html
ARG TERRAFORM_VERSION
# check tflint version: https://github.com/terraform-linters/tflint/releases
# check terragrunt version: https://github.com/gruntwork-io/terragrunt/releases

RUN apk update \
    && apk add --no-cache curl unzip ca-certificates zsh jq

# This Dockerfile adds a non-root user with sudo access. Use the “remoteUser” property in
# devcontainer.json to use it. More info: https://aka.ms/vscode-remote/containers/non-root-user.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# terraform, tflint, terragrunt
RUN cd /usr/local/bin \
    && if [[ -z "$TERRAFORM_VERSION" ]] ; then TERRAFORM_VERSION=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r -M ".current_version") ; else echo TERRAFORM_VERSION=$TERRAFORM_VERSION ; fi \
    && curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip \
    && rm -f terraform.zip \
    && curl -sSL https://github.com/terraform-linters/tflint/releases/latest/download/tflint_linux_amd64.zip -o tflint_linux_amd64.zip \
    && unzip tflint_linux_amd64.zip \
    && rm tflint_linux_amd64.zip \
    && curl -sSL https://github.com/gruntwork-io/terragrunt/releases/latest/download/terragrunt_linux_amd64 -o terragrunt \
    && chmod u+x terragrunt

