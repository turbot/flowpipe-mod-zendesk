variable "api_token" {
  type        = string
  description = "The Zendesk personal access token to authenticate to the Zendesk."
}

variable "subdomain" {
  type        = string
  description = "The subdomain to which the Zendesk account is associated to."
}

variable "user_email" {
  type        = string
  description = "The email address of the user which has been used to access the zendesk account."
}
