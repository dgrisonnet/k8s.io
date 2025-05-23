/*
Copyright 2023 The Kubernetes Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

data "aws_caller_identity" "current" {
  provider = aws.registry-k8s-io-prod
}

data "aws_region" "current" {
  provider = aws.registry-k8s-io-prod
}

data "aws_organizations_organization" "current" {}


locals {
  assume_role_arn                 = "arn:aws:iam::${local.registry_k8s_io_prod_account_id}:role/OrganizationAccountAccessRole"
  registry_k8s_io_prod_name       = "k8s-infra-registry-k8s-io-prod"
  registry_k8s_io_prod_ci_index   = index(data.aws_organizations_organization.current.accounts[*].name, local.registry_k8s_io_prod_name)
  registry_k8s_io_prod_account_id = data.aws_organizations_organization.current.accounts[local.registry_k8s_io_prod_ci_index].id
}
