pipeline "delete_user" {
  description = "Delete a user."

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

  step "http" "delete_user" {
    title  = "Delete a user"
    method = "delete"
    url    = "https://turbotsupport.zendesk.com/api/v2/users/${param.user_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.zendesk_token}")}"
    }
  }

  output "new_user_name" {
    value = jsondecode(step.http.delete_user.response_body).users.name
  }
  output "response_body" {
    value = step.http.delete_user.response_body
  }
  output "response_headers" {
    value = step.http.delete_user.response_headers
  }
  output "status_code" {
    value = step.http.delete_user.status_code
  }
}
