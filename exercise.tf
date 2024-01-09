#creating a usergroup

resource "aws_iam_group" "data-science" {
  name = "data-team"
  path = "/users/"
}

#creating a user

resource "aws_iam_user" "curtis-jones" {
  name = "curtis-jones"
  path = "/system/"

  tags = {
    tag-key = "data-team"
  }
}

# adding a user to the usergroup

resource "aws_iam_user_group_membership" "data-team-add" {
  user = aws_iam_user.curtis-jones.name

  groups = [
    aws_iam_group.data-science.name,
   ]
}

# creating a policy

resource "aws_iam_policy" "data-team-access" {
  name        = "data-team-access"
  path        = "/"
  description = "policy to give data team access"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

# creating a policy attachment

resource "aws_iam_policy_attachment" "data-team-attach" {
  name       = "data-team-access-attachment"
  groups     = [aws_iam_group.data-science.name]
  policy_arn = aws_iam_policy.data-team-access.arn
}

# creating an accesskey for the user

resource "aws_iam_access_key" "curtis-access-key" {
  user = aws_iam_user.curtis-jones.name
}

# saving the key and secret key to ssm

resource "aws_ssm_parameter" "curtis-data-access-key" {
  name  = "curtis-data-access-key"
  type  = "String"  
  value = aws_iam_access_key.curtis-access-key.id
}

resource "aws_ssm_parameter" "curtis-data-secret-key" {
  name  = "curtis-data-secret-key"
  type  = "String" 
  value = aws_iam_access_key.curtis-access-key.secret
}
