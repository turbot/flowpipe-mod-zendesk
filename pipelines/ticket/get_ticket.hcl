// usage: flowpipe pipeline run get_ticket  --execution-mode synchronous --pipeline-arg token="HBYYYYYGMuAGBuG9hipJTQQQQQVZwX5rRfwB0xuM" --pipeline-arg user_email="madhushree@turbot.com" --pipeline-arg subdomain="turbotsupport" --pipeline-arg ticket_id="3"

pipeline "get_ticket" {
  title       = "Get ticket"
  description = "Get a ticket by its ticket ID."

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

  step "http" "get_ticket" {
    title  = "Get details of a ticket in your account"
    method = "get"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.token}")}"
    }
  }

  output "ticket" {
    description = "Details of a particular ticket."
    value       = jsondecode(step.http.get_ticket.response_body).ticket
  }
}
