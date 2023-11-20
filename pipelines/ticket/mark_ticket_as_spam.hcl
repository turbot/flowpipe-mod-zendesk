# usage: flowpipe pipeline run mark_ticket_as_spam --pipeline-arg ticket_id="13"
pipeline "mark_ticket_as_spam" {
  title       = "Mark Ticket as Spam"
  description = "Mark a ticket as spam and suspend the user."

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

  step "http" "mark_ticket_as_spam" {
    method = "put"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}/mark_as_spam.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.api_token}")}"
    }
  }
}
