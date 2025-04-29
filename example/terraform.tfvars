region = "us-central1"

project_id = "nw-opstree-dev-landing-zone"

enable_secret_manager_api = true

secrets = [
  {
    name             = "my-secret-1"
    secret_data      = "very-secret-data-1"
    replication_type = "auto"
    role             = "roles/secretmanager.secretAccessor"
    member           = "user@gmail.com"
  },
  {
    name                  = "my-secret-2"
    secret_data           = "very-secret-data-2"
    replication_type      = "user_managed"
    replication_locations = ["us-central1", "europe-west1"]
    role                  = "roles/secretmanager.secretAccessor"
    member               = "serviceAccoun.com"
  }
]
