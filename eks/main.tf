locals {
  cluster_name                                = "education-cluster"
  alb_ingress_controller_namespace            = "kube-system"
  alb_ingress_controller_service_account_name = "aws-load-balancer-controller"
}