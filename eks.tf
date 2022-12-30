module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name                   = local.name
  cluster_version                = local.cluster_version
  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    # We're using cilium's ENI integration
    # vpc-cni = {
    #   most_recent = true
    #   configuration_values = jsonencode({
    #     env = {
    #       # Reference docs https://docs.aws.amazon.com/eks/latest/userguide/cni-increase-ip-addresses.html
    #       ENABLE_PREFIX_DELEGATION = "true"
    #       WARM_PREFIX_TARGET       = "1"
    #     }
    #   })
    # }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  manage_aws_auth_configmap = true

  eks_managed_node_group_defaults = {
    ami_type                   = "AL2_x86_64"
    instance_types             = local.instance_types
    iam_role_attach_cni_policy = true
  }

  eks_managed_node_groups = {
    # Node group with sensible defaults, add more node groups if you want to try stuff
    standard_node_group = {
      name            = "standard"
      use_name_prefix = true
      description     = "Node group with sensible defaults, add more node groups if you want to try stuff"

      subnet_ids = module.vpc.private_subnets

      min_size     = 1
      max_size     = 5
      desired_size = 2

      ami_id                     = data.aws_ami.eks_default.image_id
      enable_bootstrap_user_data = true
      bootstrap_extra_args       = "--container-runtime containerd"

      pre_bootstrap_user_data = <<-EOT
        export CONTAINER_RUNTIME="containerd"
      EOT

      capacity_type        = "SPOT"
      force_update_version = true
      instance_types       = local.instance_types
      labels               = local.labels
      taints               = local.taints

      update_config = {
        max_unavailable_percentage = 33 # or set `max_unavailable`
      }

      ebs_optimized           = true
      disable_api_termination = false
      enable_monitoring       = true

      block_device_mappings = local.block_device_mappings

      metadata_options = local.metadata_options

      create_iam_role          = true
      iam_role_name            = "eks-managed-node-group-standard"
      iam_role_use_name_prefix = false
      iam_role_description     = "EKS managed node group standard role"
      iam_role_tags = {
        Purpose = "Protector of the kubelet"
      }
      iam_role_additional_policies = local.iam_role_additional_policies

      tags = local.tags
    }
  }

  tags = local.tags
}