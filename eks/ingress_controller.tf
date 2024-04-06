# Create IAM Role for ALB Ingress Controller
module "alb_ingress_controller_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name                              = "CodeCationALBIngressController"
  attach_load_balancer_controller_policy = true
  allow_self_assume_role                 = true
  vpc_cni_enable_ipv4                    = true
  role_policy_arns = {
    AmazonEKS_CNI_Policy = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  }
  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }
}

# Create Service Account
resource "kubernetes_service_account" "service-account" {
  metadata {
    name      = local.alb_ingress_controller_service_account_name
    namespace = local.alb_ingress_controller_namespace
    # labels = {
    #   "app.kubernetes.io/name"       = "aws-load-balancer-controller"
    #   "app.kubernetes.io/component"  = "controller"
    #   "app.kubernetes.io/managed-by" = "Helm"
    # }
    annotations = {
      "eks.amazonaws.com/role-arn"               = module.alb_ingress_controller_role.iam_role_arn
      "eks.amazonaws.com/sts-regional-endpoints" = "true"
      "meta.helm.sh/release-name"                = "alb-ingress-controller"
      "meta.helm.sh/release-namespace"           = "kube-system"
    }
  }
}

# Provide ALB-ingress-load-balancer through HELM:
resource "helm_release" "alb_ingress_controller" {
  depends_on = [kubernetes_service_account.service-account]
  name       = "alb-ingress-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.7.2"
  namespace  = local.alb_ingress_controller_namespace

  values = [
    yamlencode({
      serviceAccount = {
        name = local.alb_ingress_controller_service_account_name

        annotations = {
          "eks.amazonaws.com/role-arn" = module.alb_ingress_controller_role.iam_role_arn
        }
      }
      region      = data.aws_region.current.name
      vpcId       = module.vpc.vpc_id
      clusterName = local.cluster_name
    })
  ]
}
