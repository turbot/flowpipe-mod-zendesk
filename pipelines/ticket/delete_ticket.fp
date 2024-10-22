pipeline "delete_ticket" {
  title       = "Delete Ticket"
  description = "Delete a ticket."

  tags = {
    recommended = "true"
  }

  param "conn" {
    type        = connection.zendesk
    description = local.conn_param_description
    default     = connection.zendesk.default
  }

  param "ticket_id" {
    type        = string
    description = "The ID of the ticket."
  }

  step "http" "delete_ticket" {
    method = "delete"
    url    = "https://${param.conn.subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.conn.email}/token:${param.conn.token}")}"
    }
  }

}
