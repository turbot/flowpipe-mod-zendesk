// usage: flowpipe pipeline run list_deleted_tickets  --execution-mode synchronous --pipeline-arg zendesk_token="HBYYYYYGMuAGBuG9hipJTQQQQQVZwX5rRfwB0xuM" --pipeline-arg user_email="madhushree@turbot.com" --pipeline-arg subdomain="turbotsupport"

pipeline "list_deleted_tickets" {
  description = "Gets a list of all deleted tickets in your account."

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

  step "http" "list_deleted_tickets" {
    title  = "List of all the deleted tickets in the account"
    method = "get"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/deleted_tickets.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.zendesk_token}")}"
    }
  }

  output "deleted_tickets" {
    description = "The list of deleted tickets in the account."
    value       = jsondecode(step.http.list_deleted_tickets.response_body).deleted_tickets
  }
}
