pipeline "list_users" {
  title       = "List Users"
  description = "List the Zendesk users."

  param "conn" {
    type        = connection.zendesk
    description = local.conn_param_description
    default     = connection.zendesk.default
  }

  step "http" "list_users" {
    method = "get"
    url    = "https://${param.conn.subdomain}.zendesk.com/api/v2/users.json?page[size]=100"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.conn.email}/token:${param.conn.token}")}"
    }

    loop {
      until = result.response_body.meta.has_more == false
      url   = result.response_body.links.next
    }
  }

  output "users" {
    description = "The list of users associated to the account."
    value       = flatten([for page, users in step.http.list_users : users.response_body.users])
  }
}
