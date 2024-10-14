pipeline "create_user" {
  title       = "Create User"
  description = "Create a user."

  tags = {
    recommended = "true"
  }

  param "conn" {
    type        = connection.zendesk
    description = local.conn_param_description
    default     = connection.zendesk.default
  }

  param "email" {
    type        = string
    description = "The email ID of the user created."
  }

  param "name" {
    type        = string
    description = "The name of the user created."
  }

  param "role" {
    type        = string
    description = "The role of the user created."
  }

  step "http" "create_user" {
    method = "post"
    url    = "https://${param.conn.subdomain}.zendesk.com/api/v2/users.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.conn.email}/token:${param.conn.token}")}"
    }
    request_body = jsonencode({ user = { for name, value in param : name => value if value != null } })
  }

  output "user" {
    description = "The user that has been created."
    value       = step.http.create_user.response_body.user
  }
}
