pipeline "update_user" {
  description = "Create a user."

  param "zendesk_token" {
    type    = string
    default = var.zendesk_token
  }

  param "user_id" {
    type    = string
    default = var.user_id
  }

  param "user_email" {
    type    = string
    default = var.user_email
  }

  param "user_name" {
    type    = string
    default = "madhushreeray30"
  }

  param "new_user_name" {
    type    = string
    default = "madhushreeraynewusername"
  }

  step "http" "update_user" {
    title  = "Update a user"
    method = "put"
    url    = "https://turbotsupport.zendesk.com/api/v2/users/${param.user_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.zendesk_token}")}"
    }
    request_body = jsonencode({
      user = {
        name = param.new_user_name
      }
    })
  }

  output "new_user_name" {
    value = jsondecode(step.http.update_user.response_body).users.name
  }
  output "response_body" {
    value = step.http.update_user.response_body
  }
  output "response_headers" {
    value = step.http.update_user.response_headers
  }
  output "status_code" {
    value = step.http.update_user.status_code
  }
}
