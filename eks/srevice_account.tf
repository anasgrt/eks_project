# resource "aws_iam_role_policy_attachment" "pod_ec2_policy-attach" {
#   role       = aws_iam_role.pod_ec2_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
# }

# resource "aws_iam_role" "pod_ec2_role" {
#   name = "pod_ec2_role"

#   assume_role_policy = <<-EOF
#   {
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Action": "sts:AssumeRole",
#         "Principal": {
#           "Service": "ec2.amazonaws.com"
#         },
#         "Effect": "Allow",
#         "Sid": ""
#       }
#     ]
#   }
#   EOF
# }

# resource "kubernetes_service_account" "pod_ec2_service_account" {
#   depends_on = [module.eks]
#   metadata {
#     name      = "pod-ec2-service-account"
#     namespace = "kube-system"
#     annotations = {
#       "eks.amazonaws.com/sts-regional-endpoints" = "true"
#       "eks.amazonaws.com/role-arn" = aws_iam_role.pod_ec2_role.arn
#     }
#   }
# }