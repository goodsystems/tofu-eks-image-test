terraform {
  required_version = "~> 1.6.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.89.0"
    }
  }
}

# Provider definition
provider "aws" {
  region = var.region

  default_tags {
    tags = {
      "Environment_name" = var.environment_name,
      "Environment_slug" = var.environment_slug,
      "Project"          = var.project,
      "ManagedBy"        = "Terraform"
    }
  }
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

provider "kubernetes" {
  host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
  cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token # Replace exec block with this
}

provider "helm" {
  kubernetes {
    host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
    cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}
