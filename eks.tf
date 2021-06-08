
data "aws_vpc" "default" {
   default = true
}


data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}



resource "aws_eks_cluster" "cluster" {
  name     = var.name
  role_arn = aws_iam_role.cluster.arn
  version  = "1.18"

  vpc_config {
    subnet_ids = data.aws_subnet_ids.default.ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_eks_cluster_policy,
    aws_iam_role_policy_attachment.cluster_eks_vpc_resource_controller,
  ]

}
