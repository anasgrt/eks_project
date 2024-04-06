provider "aws" {
  region = var.region

  assume_role {
    role_arn = "arn:aws:iam::820116308106:role/admin"
  }
  default_tags {
    tags = {
      "owner" = "education-eks"
    }
  }
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.education_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.education_cluster.token
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    command     = "aws"
  }
  # config_path            = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.education_cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.education_cluster.token
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
      command     = "aws"
    }
    # config_context         = "./kube/config"
  }
}

provider "tls" {}