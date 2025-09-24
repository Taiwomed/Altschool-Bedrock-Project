data "aws_iam_policy_document" "dev_ro_policy" {
  statement {
    actions   = ["eks:DescribeCluster", "eks:ListClusters", "eks:AccessKubernetesApi"]
    resources = ["*"]
  }

  statement {
    actions   = ["logs:DescribeLogGroups", "logs:DescribeLogStreams", "logs:GetLogEvents", "logs:FilterLogEvents"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "dev_ro_policy" {
  name        = "${local.name}-dev-ro-policy"
  description = "Read-only access to EKS and logs"
  policy      = data.aws_iam_policy_document.dev_ro_policy.json
}
