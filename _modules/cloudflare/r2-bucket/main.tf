resource "cloudflare_r2_bucket" "cloudflare-bucket" {
  account_id = var.cloudflare_r2_account_id
  name       = "my-tf-test-bucket"
  location   = "WEUR"
}