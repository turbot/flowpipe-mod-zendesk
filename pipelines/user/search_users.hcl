pipeline "search_users" {
  description = "Search the users."

  param "zendesk_token" {
    type    = string
    default = var.zendesk_token
  }

  param "user_email" {
    type    = string
    default = var.user_email
  }

  step "http" "search_users" {
    title  = "Search the users"
    method = "get"
    url    = "https://turbotsupport.zendesk.com/api/v2/users/search.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.zendesk_token}")}"
    }
  }

  output "users" {
    value = jsondecode(step.http.search_users.response_body).users
  }
  output "response_body" {
    value = step.http.search_users.response_body
  }
  output "response_headers" {
    value = step.http.search_users.response_headers
  }
  output "status_code" {
    value = step.http.search_users.status_code
  }
}
