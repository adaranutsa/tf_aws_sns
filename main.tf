resource "aws_sns_topic" "t" {
  name = "${var.name}"

  display_name    = "${var.display_name}"
  policy          = "${var.policy}"
  delivery_policy = "${var.delivery_policy}"
}

resource "aws_sns_topic_policy" "default" {
  arn = "${aws_sns_topic.t.arn}"

  policy = "${data.aws_iam_policy_document.sns-topic-policy.json}"
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = "${aws_sns_topic.t.arn}"
  protocol  = "${var.endpoint_protocol}"
  endpoint  = "${var.endpoint}"
}

data "aws_iam_policy_document" "sns-topic-policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        "${var.account-id}",
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      "${aws_sns_topic.t.arn}",
    ]

    sid = "__default_statement_ID"
  }
