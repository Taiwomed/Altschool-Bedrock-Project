resource "aws_iam_user" "developer_readonly" {
  name = "${local.name}-developer-ro"
  tags = local.tags
}

resource "aws_iam_user_policy_attachment" "attach_dev_ro_policy" {
  user       = aws_iam_user.developer_readonly.name
  policy_arn = aws_iam_policy.dev_ro_policy.arn
}

resource "aws_iam_access_key" "developer_readonly" {
  user = aws_iam_user.developer_readonly.name
}

output "developer_access_key_id" {
  value = aws_iam_access_key.developer_readonly.id
  sensitive = true
}

output "developer_secret_access_key" {
  value = aws_iam_access_key.developer_readonly.secret
  sensitive = true
}
