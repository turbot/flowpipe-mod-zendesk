pipeline "list_ticket_comments" {
  title       = "List Ticket Comments"
  description = "List the ticket comments."

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

  param "include" {
    type        = string
    description = "Include 'users' to list email CCs by side-loading users."
    optional    = true
  }

  param "include_inline_images" {
    type        = bool
    description = "Include inline images in the response (default is false)."
    optional    = true
  }

  step "http" "list_ticket_comments" {
    method = "get"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}/comments.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.api_token}")}"
    }
  }

  output "ticket_comments" {
    description = "The list of all comments for a ticket."
    value       = step.http.list_ticket_comments.response_body
  }
}
