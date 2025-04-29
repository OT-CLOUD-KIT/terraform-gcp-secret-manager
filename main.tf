resource "google_project_service" "secretmanager" {
  count   = var.enable_secret_manager_api ? 1 : 0
  service = "secretmanager.googleapis.com"
}

resource "google_secret_manager_secret" "secrets" {
  for_each = { for secret in var.secrets : secret.name => secret }

  secret_id = each.value.name

  replication {
    dynamic "auto" {
      for_each = each.value.replication_type == "auto" ? [1] : []
      content {}
    }

    dynamic "user_managed" {
      for_each = each.value.replication_type == "user_managed" ? [1] : []
      content {
        dynamic "replicas" {
          for_each = each.value.replication_locations
          content {
            location = replicas.value
          }
        }
      }
    }
  }

  depends_on = [google_project_service.secretmanager]
}

resource "google_secret_manager_secret_version" "secret_versions" {
  for_each = { for secret in var.secrets : secret.name => secret }

  secret      = google_secret_manager_secret.secrets[each.key].id
  secret_data = each.value.secret_data
}

resource "google_secret_manager_secret_iam_member" "secret_iam" {
  for_each = {
    for secret in var.secrets : secret.name => secret if secret.member != null && secret.role != null
  }

  secret_id = google_secret_manager_secret.secrets[each.key].id
  role      = each.value.role
  member    = each.value.member
}
