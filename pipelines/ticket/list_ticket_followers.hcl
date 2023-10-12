// usage: flowpipe pipeline run list_ticket_followers  --execution-mode synchronous --pipeline-arg zendesk_token="HBYYYYYGMuAGBuG9hipJTQQQQQVZwX5rRfwB0xuM" --pipeline-arg user_email="madhushree@turbot.com" --pipeline-arg subdomain="turbotsupport" --pipeline-arg ticket_id="13"

pipeline "list_ticket_followers" {
  description = "List all ticket problems in your account."

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

  param "ticket_id" {
    type        = string
    description = "The ID of the ticket for which followers are to be listed."
    default     = ""
  }

  step "http" "list_ticket_followers" {
    title  = "List all ticket problems in the account"
    method = "get"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}/followers.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.zendesk_token}")}"
    }
  }

  output "followers" {
    value = jsondecode(step.http.list_ticket_followers.response_body).users
  }
  output "user_id" {
    value = jsondecode(step.http.list_ticket_followers.response_body).users[*].id
  }
  output "user_name" {
    value = jsondecode(step.http.list_ticket_followers.response_body).users[*].name
  }
  output "response_body" {
    value = step.http.list_ticket_followers.response_body
  }
  output "response_headers" {
    value = step.http.list_ticket_followers.response_headers
  }
  output "status_code" {
    value = step.http.list_ticket_followers.status_code
  }
}
