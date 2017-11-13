variable "name" {}

variable "display_name" {
  description = "The display name for the SNS topic."
  default     = ""
}

variable "policy" {
  description = "The fully-formed AWS policy as JSON."
  default     = ""
}

variable "delivery_policy" {
  description = "The SNS delivery policy."
  default     = ""
}

variable "account-id" {
  description = "The Account ID"
  default     = ""
}

variable "endpoint_protocol" {
  description = "SNS subscription endpoint protocol"
  default     = ""
}

variable "endpoint" {
  description = "SNS subscription endpoint"
  default     = ""
}
