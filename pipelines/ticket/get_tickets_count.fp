pipeline "get_tickets_count" {
  title       = "Count Tickets"
  description = "Count the number of tickets."

  param "conn" {
    type        = connection.zendesk
    description = local.conn_param_description
    default     = connection.zendesk.default
  }

  step "http" "get_tickets_count" {
    method = "get"
    url    = "https://${param.conn.subdomain}.zendesk.com/api/v2/tickets/count.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.conn.email}/token:${param.conn.token}")}"
    }
  }

  output "tickets_count" {
    description = "The number of tickets in the account."
    value       = step.http.get_tickets_count.response_body
  }
}
