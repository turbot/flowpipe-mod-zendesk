// usage: flowpipe pipeline run count_ticket_comments --pipeline-arg ticket_id="29"

pipeline "count_ticket_comments" {
  title       = "Count Ticket Comments"
  description = "Count the number of ticket comments."

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

  step "http" "count_ticket_comments" {
    title  = "Count Ticket Comments"
    method = "get"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}/comments/count.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.api_token}")}"
    }
  }

  output "tickets_count" {
    description = "The number of ticket comments in an account."
    value       = jsondecode(step.http.count_ticket_comments.response_body).count.value
  }
}
