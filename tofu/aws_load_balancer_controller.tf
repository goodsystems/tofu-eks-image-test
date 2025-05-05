data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket = "${var.TFSTATE_S3BUCKET_PREFIX}-${var.environment_name}-terraform-state"
    key    = "terraform-eks/terraform.tfstate"
    region = "us-east-1"
  }
}

module "eks-blueprints-addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "v1.21.0"

  cluster_name                        = data.terraform_remote_state.eks.outputs.cluster_name
  cluster_endpoint                    = data.terraform_remote_state.eks.outputs.cluster_endpoint
  cluster_version                     = data.terraform_remote_state.eks.outputs.cluster_version
  oidc_provider_arn                   = data.terraform_remote_state.eks.outputs.oidc_provider_arn
  enable_aws_load_balancer_controller = true
}
