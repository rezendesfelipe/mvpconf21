#!/bin/bash

set -e

export LOCATION=eastus2
export COMMON_RESOURCE_GROUP_NAME=rg-ts-shared-prd
export TF_STATE_STORAGE_ACCOUNT_NAME=sacloudservicesprd
export TF_STATE_CONTAINER_NAME=terraform-state
export KEYVAULT_NAME=kv-cloudservices-prd
export LABNAME=lab-001