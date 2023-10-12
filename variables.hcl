// For authentication

variable "token" {
  type        = string
  description = "The Zendesk personal access token to authenticate to the Zendesk."
  default     = "HBGMIYVGMuAGBuG9hipJT1EU3UVZwX5rRfwB0xuM"
}

variable "user_email" {
  type        = string
  description = "The email address of the user which has been used to access the zendesk account."
  default     = "madhushree@turbot.com"
}

variable "subdomain" {
  type        = string
  description = "The subdomain to which the Zendesk account is associated to."
  default     = "turbotsupport"
}

// For tickets pipeline

variable "ticket_id" {
  type        = string
  description = "The ID of a ticket in the account."
  default     = "1"
}