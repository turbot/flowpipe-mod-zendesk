pipeline "list_ticket_followers" {
  title       = "List Ticket Followers"
  description = "List the followers of a ticket."

  param "cred" {
    type        = string
    description = "Name for credentials to use. If not provided, the default credentials will be used."
    default     = "default"
  }

  param "ticket_id" {
    type        = string
    description = "The ID of the ticket."
  }

  step "http" "list_ticket_followers" {
    method = "get"
    url    = "https://${credential.zendesk[param.cred].subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}/followers.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${credential.zendesk[param.cred].email}/token:${credential.zendesk[param.cred].token}")}"
    }
  }

  output "ticket_followers" {
    description = "The list of followers of a ticket."
    value       = step.http.list_ticket_followers.response_body
  }
}
