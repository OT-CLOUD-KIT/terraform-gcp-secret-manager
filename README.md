# Terraform GCP Secret Manager

[![Opstree Solutions][opstree_avatar]][opstree_homepage]<br/>[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

This Terraform module provisions and manages Google Secret Manager resources.
It enables the Secret Manager API, creates multiple secrets with either auto or user-managed replication based on input, stores secret versions, and grants IAM roles dynamically to users or service accounts.
The design is flexible to support different replication strategies and secure access controls per secret.

## Architecture

<img width="800" length="800" alt="Terraform" src="https://github.com/user-attachments/assets/c6b0843b-8a62-4a7a-8c7c-8dd6f1e589d0">


## Providers

| Name                                              | Version  |
|---------------------------------------------------|----------|
| <a name="provider_gcp"></a> [gcp](#provider\_gcp) | 5.0.0   |

## Usage

```hcl
module "secrets" {
  source                    = "./module"
  enable_secret_manager_api = var.enable_secret_manager_api
  secrets                   = var.secrets
}

# Variable values

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
```

## Inputs

| Name | Description | Type | Default | Required | 
|------|-------------|:----:|---------|:--------:|
|**project_id**| The ID of the project | string | { } | yes| 
|**region**| Region where resource will be created. | string | "us-central1" | yes | 
|**enable_secret_manager_api**| Enable Secret Manager API | bool | true | yes| 
|**secrets**| Secrets details | list(object) | [ ] | yes | 


## Output
| Name | Description |
|------|-------------|
|**secret_names**| Secret names created | 
|**secret_ids**| Secret IDs created | 
