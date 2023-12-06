pipeline "list_ticket_comments" {
  title       = "List Ticket Comments"
  description = "List the ticket comments."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
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
    url    = "https://${credential.zendesk[param.cred].subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}/comments.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${credential.zendesk[param.cred].email}/token:${credential.zendesk[param.cred].token}")}"
    }
  }

  output "ticket_comments" {
    description = "The list of all comments for a ticket."
    value       = step.http.list_ticket_comments.response_body.comments
  }
}
