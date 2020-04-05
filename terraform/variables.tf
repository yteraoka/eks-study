variable "project_name" {}

variable "vpc_cidr" {}

variable "public_subnet_cidrs" {
  type = list(object({
    az   = string
    cidr = string
  }))
}

variable "private_subnet_cidrs" {
  type = list(object({
    az   = string
    cidr = string
  }))
}

variable "nat_gateway_count" {
  default = 1
}

locals {
  common_tags = {
    Project   = var.project_name
    Terraform = var.project_name
  }
}

#
# for backend
#
variable "bucket" {
  description = "s3 backend 用 bucket name"
}
variable "key" {
  description = "s3 backend 用 state file の key"
}
variable "region" {
  default = "ap-northeast-1"
}
variable "dynamodb_table" {
  description = "state file の lock 用 DynamoDB Table name"
}

