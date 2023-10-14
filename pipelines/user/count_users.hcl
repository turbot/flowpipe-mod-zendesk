// usage: flowpipe pipeline run count_users  --execution-mode synchronous --pipeline-arg api_token="HBYYYYYGMuAGBuG9hipJTQQQQQVZwX5rRfwB0xuM" --pipeline-arg user_email="madhushree@turbot.com" --pipeline-arg subdomain="turbotsupport"

pipeline "count_users" {
  title       = "Count Users"
  description = "Count the number of users."

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

  step "http" "count_users" {
    title  = "Count Users"
    method = "get"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/users/count.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.api_token}")}"
    }
  }

  output "user_count" {
    description = "The number of users associated to the account."
    value       = jsondecode(step.http.count_users.response_body).count.value
  }
}
