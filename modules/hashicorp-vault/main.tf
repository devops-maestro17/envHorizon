provider "vault" {
  address          = var.vault_address
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id   = var.vault_role_id
      secret_id = var.vault_secret_id
    }
  }
}

data "vault_kv_secret_v2" "kv_secret" {
  mount = "kv"
  name  = "db"
}