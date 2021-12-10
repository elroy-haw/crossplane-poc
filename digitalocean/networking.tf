resource "digitalocean_vpc" "vpc" {
  name        = format("%s-vpc", local.project_name)
  region      = local.region
  description = format("VPC for %s", local.project_name)
  ip_range    = local.ip_range
}