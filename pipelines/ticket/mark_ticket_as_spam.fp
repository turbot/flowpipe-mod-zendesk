pipeline "mark_ticket_as_spam" {
  title       = "Mark Ticket as Spam"
  description = "Mark a ticket as spam and suspend the user."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "ticket_id" {
    type        = string
    description = "The ID of the ticket."
  }

  step "http" "mark_ticket_as_spam" {
    method = "put"
    url    = "https://${credential.zendesk[param.cred].subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}/mark_as_spam.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${credential.zendesk[param.cred].email}/token:${credential.zendesk[param.cred].token}")}"
    }
  }
}
