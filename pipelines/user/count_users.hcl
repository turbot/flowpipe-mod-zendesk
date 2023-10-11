pipeline "count_users" {
  description = "Count the number of users."

  param "zendesk_token" {
    type    = string
    default = var.zendesk_token
  }

  param "user_email" {
    type    = string
    default = var.user_email
  }

  step "http" "count_users" {
    title  = "Count the number of users"
    method = "get"
    url    = "https://turbotsupport.zendesk.com/api/v2/users/count.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.zendesk_token}")}"
    }
  }

  output "user_count" {
    value = jsondecode(step.http.count_users.response_body).count.value
  }
  output "response_body" {
    value = step.http.count_users.response_body
  }
  output "response_headers" {
    value = step.http.count_users.response_headers
  }
  output "status_code" {
    value = step.http.count_users.status_code
  }
}
