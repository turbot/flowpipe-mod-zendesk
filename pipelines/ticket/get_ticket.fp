pipeline "get_ticket" {
  title       = "Get Ticket"
  description = "Get a ticket by ticket ID."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "ticket_id" {
    type        = string
    description = "The ID of the ticket."
  }

  step "http" "get_ticket" {
    method = "get"
    url    = "https://${credential.zendesk[param.cred].subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${credential.zendesk[param.cred].email}/token:${credential.zendesk[param.cred].token}")}"
    }
  }

  output "ticket" {
    description = "Details of a particular ticket."
    value       = step.http.get_ticket.response_body.ticket
  }
}
