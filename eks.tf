resource "aws_iam_role" "eks" {
  name = "eks-cluster-demo"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks.name
}

resource "aws_eks_cluster" "my-cluster" {
  name     = "my-cluster"
  version  = "1.27"
  role_arn = aws_iam_role.eks.arn

  vpc_config {
    subnet_ids = [] # add subnets here
  }

  depends_on = [aws_iam_role_policy_attachment.amazon_eks_cluster_policy]
}