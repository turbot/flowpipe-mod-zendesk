# usage: flowpipe pipeline run get_ticket --pipeline-arg ticket_id="3"
pipeline "get_ticket" {
  title       = "Get Ticket"
  description = "Get a ticket by its ticket ID."

  param "api_token" {
    type        = string
    description = local.api_token_param_description
    default     = var.api_token
  }

  param "user_email" {
    type        = string
    description = local.user_email_param_description
    default     = var.user_email
  }

  param "subdomain" {
    type        = string
    description = local.subdomain_param_description
    default     = var.subdomain
  }

  param "ticket_id" {
    type        = string
    description = "The ID of the ticket."
  }

  step "http" "get_ticket" {
    title  = "Get Ticket"
    method = "get"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.api_token}")}"
    }
  }

  output "ticket" {
    description = "Details of a particular ticket."
    value       = step.http.get_ticket.response_body.ticket
  }
}
