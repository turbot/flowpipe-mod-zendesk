# usage: flowpipe pipeline run get_ticket_comments_count --pipeline-arg ticket_id="29"
pipeline "get_ticket_comments_count" {
  title       = "Count Ticket Comments"
  description = "Count the number of ticket comments."

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

  step "http" "get_ticket_comments_count" {
    method = "get"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}/comments/count.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.api_token}")}"
    }
  }

  output "ticket_comments_count" {
    description = "The number of ticket comments in an account."
    value       = step.http.get_ticket_comments_count.response_body.count.value
  }
}
