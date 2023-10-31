// usage: flowpipe pipeline run list_users

pipeline "list_users" {
  title       = "List Users"
  description = "List the users."

  param "api_token" {
    type        = string
    description = "API tokens are auto-generated passwords in the Zendesk Admin Center."
    default     = var.api_token
  }

  param "user_email" {
    type        = string
    description = "The email ID of the user the account belongs to."
    default     = var.user_email
  }

  param "subdomain" {
    type        = string
    description = "The subdomain under which the account is created."
    default     = var.subdomain
  }

  step "http" "list_users" {
    title  = "List Users"
    method = "get"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/users.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.api_token}")}"
    }
  }

  output "users" {
    description = "The list of users associated to the account."
    value       = jsondecode(step.http.list_users.response_body).users
  }
}
