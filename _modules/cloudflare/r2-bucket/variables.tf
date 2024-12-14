# Variable data

variable "cloudflare_r2_account_id" {
  type    = string
  sensitive = true
  description = "Cloudflare R2 Account ID"
}

variable "cloudflare_r2_api_token" {
  type    = string
  sensitive = true
  description = "Cloudflare R2 API Token"
}