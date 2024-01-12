resource "aws_iam_policy" "data_eng_full_access_policy" {
  name        = "data_eng_full_access_policy"
  description = "Policy for full access to data engineering resources"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      #added iam full access
      {
        Action   = ["iam:*", "organizations:Describe*", "organizations:List*"]
        Effect   = "Allow"
        Resource = "*"
      },
      # s3 full access
      {
        Action   = ["s3:*", "s3-object-lambda:*"]
        Effect   = "Allow"
        Resource = "*"
      },
      # for ssm full access
      {
        Action   = [
          "cloudwatch:PutMetricData",
          "ds:CreateComputer",
          "ds:DescribeDirectories",
          "ec2:DescribeInstanceStatus",
          "logs:*",
          "ssm:*",
          "ec2messages:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = ["iam:CreateServiceLinkedRole"]
        Effect   = "Allow"
        Resource = "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM*"
        Condition = {
          StringLike = {
            "iam:AWSServiceName" = "ssm.amazonaws.com"
          }
        }
      },
      {
        Action   = ["iam:DeleteServiceLinkedRole", "iam:GetServiceLinkedRoleDeletionStatus"]
        Effect   = "Allow"
        Resource = "arn:aws:iam::*:role/aws-service-role/ssm.amazonaws.com/AWSServiceRoleForAmazonSSM*"
      },
      {
        Action   = [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
# policy attachment
resource "aws_iam_group_policy_attachment" "data_eng_full_access_attachment" {
  group      = "data_engineering_hub"
  policy_arn = aws_iam_policy.data_eng_full_access_policy.arn
}
