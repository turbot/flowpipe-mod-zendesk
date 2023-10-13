// usage: flowpipe pipeline run delete_ticket  --execution-mode synchronous --pipeline-arg token="HBYYYYYGMuAGBuG9hipJTQQQQQVZwX5rRfwB0xuM" --pipeline-arg user_email="madhushree@turbot.com" --pipeline-arg subdomain="turbotsupport" --pipeline-arg ticket_id="3"

pipeline "delete_ticket" {
  title       = "Delete ticket"
  description = "Delete a ticket."

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

  param "ticket_id" {
    type        = string
    description = "The ID of the ticket."
  }

  step "http" "delete_ticket" {
    title  = "Delete a ticket in your account"
    method = "delete"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.token}")}"
    }
  }
  output "status_code" {
    description = "HTTP response status code."
    value       = step.http.delete_ticket.status_code
  }
}
