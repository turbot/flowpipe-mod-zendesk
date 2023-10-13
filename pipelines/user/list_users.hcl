// usage: flowpipe pipeline run list_users  --execution-mode synchronous --pipeline-arg token="HBYYYYYGMuAGBuG9hipJTQQQQQVZwX5rRfwB0xuM" --pipeline-arg user_email="madhushree@turbot.com" --pipeline-arg subdomain="turbotsupport"

pipeline "list_users" {
  title       = "List users"
  description = "List the users."

  param "token" {
    type        = string
    description = "API tokens are auto-generated passwords in the Zendesk Admin Center."
    default     = var.token
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
    title  = "List users"
    method = "get"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/users.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.token}")}"
    }
  }

  output "users" {
    description = "The list of users associated to the account."
    value       = jsondecode(step.http.list_users.response_body).users
  }
}
