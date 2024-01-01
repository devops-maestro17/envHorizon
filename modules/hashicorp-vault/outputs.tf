output "vault_db_username" {
  value = data.vault_kv_secret_v2.kv_secret.data["username"]
}

output "vault_db_password" {
  value = data.vault_kv_secret_v2.kv_secret.data["password"]
}