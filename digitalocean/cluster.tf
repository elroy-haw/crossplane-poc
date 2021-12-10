data "digitalocean_kubernetes_versions" "versions" {
  version_prefix = "1.21."
}

resource "digitalocean_kubernetes_cluster" "cluster" {
  name          = format("%s-cluster", local.project_name)
  region        = local.region
  version       = data.digitalocean_kubernetes_versions.versions.latest_version
  vpc_uuid      = digitalocean_vpc.vpc.id
  auto_upgrade  = false
  surge_upgrade = false
  tags          = local.tags

  node_pool {
    name       = format("%s-default-worker-pool", local.project_name)
    size       = local.size
    node_count = 2
    auto_scale = false
    tags       = local.tags
  }
}