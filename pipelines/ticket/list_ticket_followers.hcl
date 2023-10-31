// usage: flowpipe pipeline run list_ticket_followers --pipeline-arg ticket_id="13"

pipeline "list_ticket_followers" {
  title       = "List Ticket Followers"
  description = "List the followers of a ticket."

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

  param "ticket_id" {
    type        = string
    description = "The ID of the ticket."
  }

  step "http" "list_ticket_followers" {
    title  = "List Ticket Followers"
    method = "get"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}/followers.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.api_token}")}"
    }
  }

  output "ticket_followers" {
    description = "The list of followers of a ticket."
    value       = jsondecode(step.http.list_ticket_followers.response_body).users
  }
}
