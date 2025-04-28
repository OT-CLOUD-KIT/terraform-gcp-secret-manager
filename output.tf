output "secret_ids" {
  value = { for k, v in google_secret_manager_secret.secrets : k => v.id }
}

output "secret_names" {
  value = { for k, v in google_secret_manager_secret.secrets : k => v.secret_id }
}
