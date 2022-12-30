resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.16.x"
  namespace        = "argocd"
  create_namespace = true

  values = [
    "${file("helm_values/argocd_values.yaml")}"
  ]

  depends_on = [
    module.eks,
    helm_release.cilium
  ]
}


