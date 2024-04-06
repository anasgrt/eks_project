# resource "kubernetes_ingress" "ingress" {
#   wait_for_load_balancer = true
#   metadata {
#     name = "ingress"
#     annotations = {
#       "kubernetes.io/ingress.class" = "alb"
#     }
#   }
#   spec {
#     rule {
#       http {
#         path {
#           path = "/kibana"
#           backend {
#             service_name = "kibana-logging"
#             service_port = 5601
#           }
#         }
#       }
#     }
#   }
# }