pipeline "create_user" {
  description = "Create a user."

  param "zendesk_token" {
    type    = string
    default = var.zendesk_token
  }

  param "user_email" {
    type    = string
    default = var.user_email
  }

  param "user_name" {
    type    = string
    default = "madhushreeray30"
  }

  param "new_user_email" {
    type    = string
    default = var.user_email
  }

  param "new_user_name" {
    type    = string
    default = "madhushreeray30"
  }

  param "new_user_role" {
    type    = string
    default = "agent"
  }

  param "new_user_custom_role_id" {
    type    = string
    default = "123456"
  }

  step "http" "create_user" {
    title  = "Create a user"
    method = "post"
    url    = "https://turbotsupport.zendesk.com/api/v2/users.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.zendesk_token}")}"
    }
    request_body = jsonencode({
      user = {
        name  = param.new_user_name
        email = param.new_user_email
        role  = param.new_user_role
        // custom_role_id = param.new_user_custom_role_id
      }
    })
  }

  output "new_user_name" {
    value = jsondecode(step.http.create_user.response_body).users.name
  }
  output "response_body" {
    value = step.http.create_user.response_body
  }
  output "response_headers" {
    value = step.http.create_user.response_headers
  }
  output "status_code" {
    value = step.http.create_user.status_code
  }
}
