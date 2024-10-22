pipeline "get_users_count" {
  title       = "Count Users"
  description = "Count the number of users."

  param "conn" {
    type        = connection.zendesk
    description = local.conn_param_description
    default     = connection.zendesk.default
  }

  step "http" "get_users_count" {
    method = "get"
    url    = "https://${param.conn.subdomain}.zendesk.com/api/v2/users/count.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.conn.email}/token:${param.conn.token}")}"
    }
  }

  output "users_count" {
    description = "The number of users associated to the account."
    value       = step.http.get_users_count.response_body.count.value
  }
}
