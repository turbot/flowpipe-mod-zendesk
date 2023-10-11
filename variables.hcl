variable "repository_full_name" {
  type        = string
  description = "The full name of the GitHub repository. Examples: turbot/steampipe, turbot/flowpipe"
  default     = "cbruno10/github-api-test"
}

variable "user_email" {
  type        = string
  description = "The email address of the user which has been used to access the zendesk account."
  default     = ""
}

variable "user_id" {
  type        = string
  description = "The user ID of the user that needs to be updated."
  default     = "55555"
}

variable "zendesk_token" {
  type        = string
  description = "The Zendesk personal access token to authenticate to the Zendesk."
  default     = ""

}