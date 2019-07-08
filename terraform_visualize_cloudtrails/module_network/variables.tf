locals {
  workstation-external-cidr = "${chomp(data.http.demo-workstation-external-ip.body)}/32"
}