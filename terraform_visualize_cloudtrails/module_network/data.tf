data "aws_availability_zones" "demo-available" {}

provider "http" {}

data "http" "demo-workstation-external-ip" {
  url = "http://icanhazip.com"
}