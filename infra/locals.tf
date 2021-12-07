locals {
  project_name = "crossplane-poc"
  region       = "sgp1"
  size         = "s-1vcpu-2gb"
  ip_range     = "10.0.0.0/20"
  tags         = [format("project:%s", local.project_name)]
}