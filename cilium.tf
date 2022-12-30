locals {
  cilium_values = templatefile("${path.module}/helm_values/cilium_values.yaml", {
      API_SERVER_IP = trim(module.eks.cluster_endpoint, "https://")
      API_SERVER_PORT = "443"
  })
}

resource "helm_release" "cilium" {
  name       = "cilium"
  repository = "https://helm.cilium.io"
  chart      = "cilium"
  version    = "1.12.x"
  namespace  = "kube-system"
  wait = false

  values = [ local.cilium_values ]

  depends_on = [
    module.eks.aws_eks_cluster
  ]
}

