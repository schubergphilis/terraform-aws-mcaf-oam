data "aws_organizations_organization" "org" {}

resource "aws_oam_sink" "default" {
  name = var.name
  tags = var.tags
}

resource "aws_oam_sink_policy" "default" {
  sink_identifier = aws_oam_sink.default.id
  policy          = data.aws_iam_policy_document.policy.json
}

data "aws_iam_policy_document" "policy" {
  statement {
    actions = ["oam:CreateLink", "oam:UpdateLink"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalOrgID"
      values   = [data.aws_organizations_organization.org.id]
    }

    resources = ["*"]
    effect    = "Allow"
  }
}
