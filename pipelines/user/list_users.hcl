// usage: flowpipe pipeline run list_users  --execution-mode synchronous --pipeline-arg zendesk_token="HBYYYYYGMuAGBuG9hipJTQQQQQVZwX5rRfwB0xuM" --pipeline-arg user_email="madhushree@turbot.com" --pipeline-arg subdomain="turbotsupport"

pipeline "list_users" {
  description = "List the users."

  param "zendesk_token" {
    type        = string
    description = "The Zendesk token for authorization"
    default     = var.zendesk_token
  }

  param "user_email" {
    type        = string
    description = "The user email ID of the user the account belongs to."
    default     = var.user_email
  }

  param "subdomain" {
    type        = string
    description = "The name of the subdomain under which the account is created."
    default     = var.subdomain
  }

  step "http" "list_users" {
    title  = "List the users"
    method = "get"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/users.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.zendesk_token}")}"
    }
  }

  output "users" {
    value = jsondecode(step.http.list_users.response_body).users
  }
  output "response_body" {
    value = step.http.list_users.response_body
  }
  output "response_headers" {
    value = step.http.list_users.response_headers
  }
  output "status_code" {
    value = step.http.list_users.status_code
  }
}
