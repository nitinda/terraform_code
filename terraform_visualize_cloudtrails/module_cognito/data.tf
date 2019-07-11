resource "random_uuid" "demo-random" { }

resource "random_string" "demo-random-string" {
  length = 25
  special = false
  upper = false
}