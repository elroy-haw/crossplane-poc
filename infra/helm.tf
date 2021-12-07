resource "helm_release" "crossplane" {
  name             = "crossplane"
  chart            = "crossplane"
  repository       = "https://charts.crossplane.io/stable"
  version          = "1.5.1"
  namespace        = "crossplane-system"
  create_namespace = true
  values           = []
}