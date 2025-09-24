# Local cluster name for naming resources

# IAM policy for AWS Load Balancer Controller
resource "aws_iam_policy" "aws_lb_controller" {
  name        = "AWSLoadBalancerControllerIAMPolicy"
  description = "IAM policy for AWS Load Balancer Controller"
  policy      = file("iam_policy.json")  # Downloaded from AWS official repo
}

# IAM role for AWS Load Balancer Controller
resource "aws_iam_role" "aws_lb_controller" {
  name = "${local.name}-aws-lb-controller"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = "arn:aws:iam::937525203833:oidc-provider/oidc.eks.us-west-2.amazonaws.com/id/41E22A6B3C3DE3F33A5B2D922C0AED91"
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "oidc.eks.us-west-2.amazonaws.com/id/41E22A6B3C3DE3F33A5B2D922C0AED91:sub" = "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }
      }
    ]
  })

  tags = local.tags
}

# Attach policy to the IAM role
resource "aws_iam_role_policy_attachment" "aws_lb_controller_attach" {
  role       = aws_iam_role.aws_lb_controller.name
  policy_arn = aws_iam_policy.aws_lb_controller.arn
}



