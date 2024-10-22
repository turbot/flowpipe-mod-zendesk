pipeline "mark_ticket_as_spam" {
  title       = "Mark Ticket as Spam"
  description = "Mark a ticket as spam and suspend the user."

  param "conn" {
    type        = connection.zendesk
    description = local.conn_param_description
    default     = connection.zendesk.default
  }

  param "ticket_id" {
    type        = string
    description = "The ID of the ticket."
  }

  step "http" "mark_ticket_as_spam" {
    method = "put"
    url    = "https://${param.conn.subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}/mark_as_spam.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.conn.email}/token:${param.conn.token}")}"
    }
  }
}
