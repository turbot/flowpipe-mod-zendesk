pipeline "show_user" {
  description = "Show a user detail."

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

  step "http" "show_user" {
    title  = "Show a user detail"
    method = "get"
    url    = "https://turbotsupport.zendesk.com/api/v2/users/${param.user_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.zendesk_token}")}"
    }
  }

  output "new_user_name" {
    value = jsondecode(step.http.show_user.response_body).users.name
  }
  output "response_body" {
    value = step.http.show_user.response_body
  }
  output "response_headers" {
    value = step.http.show_user.response_headers
  }
  output "status_code" {
    value = step.http.show_user.status_code
  }
}
