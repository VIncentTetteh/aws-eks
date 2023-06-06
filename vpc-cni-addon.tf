resource "aws_eks_addon" "vpc-cni" {
  cluster_name             = aws_eks_cluster.my-cluster.name
  addon_name               = "vpc-cni"
  addon_version            = "v1.12.6-eksbuild.2"
  service_account_role_arn = aws_iam_role.vpc-cni.arn
}