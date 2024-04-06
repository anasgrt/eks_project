
resource "aws_iam_role_policy_attachment" "green_ebs_csi_role_policy_attach" {
  # role       = aws_iam_role.managed-groups-eks-iam-role.name
  role       = module.eks.eks_managed_node_groups["blue"].iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

resource "aws_iam_role_policy_attachment" "blue_ebs_csi_role_policy_attach" {
  role       = module.eks.eks_managed_node_groups["green"].iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

# resource "aws_iam_role" "managed-groups-eks-iam-role" {
#   name = "managed-groups-eks-iam-role"

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       },
#     ]
#   })

#   tags = {
#     tag-key = "education-eks"
#   }
# }

# resource "aws_iam_role_policy_attachment" "green_ebs_csi_role_policy_attach" {
#   role       = data.aws_iam_role.green_eks_node_group_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
# }

# resource "aws_iam_role_policy_attachment" "blue_ebs_csi_role_policy_attach" {
#   role       = data.aws_iam_role.blue_eks_node_group_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
# }

# data "aws_iam_role" "blue_eks_node_group_role" {
#   name = "blue-eks-node-group-20240329122229201800000001"  # Name of the IAM Role you want to retrieve
# }

# data "aws_iam_role" "green_eks_node_group_role" {
#   name = "green-eks-node-group-20240329122229201900000002"  # Name of the IAM Role you want to retrieve
# }
