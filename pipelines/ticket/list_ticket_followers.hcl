// usage: flowpipe pipeline run list_ticket_followers  --execution-mode synchronous --pipeline-arg token="HBYYYYYGMuAGBuG9hipJTQQQQQVZwX5rRfwB0xuM" --pipeline-arg user_email="madhushree@turbot.com" --pipeline-arg subdomain="turbotsupport" --pipeline-arg ticket_id="13"

pipeline "list_ticket_followers" {
  title       = "List ticket followers"
  description = "List the followers of a ticket."

  param "token" {
    type        = string
    description = "The API token for authorization."
    default     = var.token
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
  }

  step "http" "list_ticket_followers" {
    title  = "List ticket followers"
    method = "get"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}/followers.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.token}")}"
    }
  }

  output "ticket_followers" {
    description = "The list of followers of a ticket."
    value       = jsondecode(step.http.list_ticket_followers.response_body).users
  }
}
