pipeline "delete_ticket" {
  title       = "Delete Ticket"
  description = "Delete a ticket."

  param "cred" {
    type        = string
    description = "Name for credentials to use. If not provided, the default credentials will be used."
    default     = "default"
  }

  param "ticket_id" {
    type        = string
    description = "The ID of the ticket."
  }

  step "http" "delete_ticket" {
    method = "delete"
    url    = "https://${credential.zendesk[param.cred].subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${credential.zendesk[param.cred].email}/token:${credential.zendesk[param.cred].token}")}"
    }
  }

}
