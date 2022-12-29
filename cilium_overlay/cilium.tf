resource "helm_release" "cilium" {
  name       = "cilium"
  repository = "https://helm.cilium.io"
  chart      = "cilium"
  version    = "1.12.x"
  namespace  = "kube-system"

  values = [
    "${file("values.yaml")}"
  ]

  depends_on = [
    module.eks
  ]
}

