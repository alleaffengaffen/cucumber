locals {
  name            = "cucumber"
  cluster_version = "1.24"
  region          = "sa-east-1"

  vpc_cidr = "10.123.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  instance_types = ["t3.medium", "t3a.medium", "t2.medium"]

  labels = {}

  taints = [
    # will be removed by cilium once initalized
    {
      key    = "node.cilium.io/agent-not-ready"
      value  = "true"
      effect = "NO_EXECUTE"
    }
  ]

  tags = {
    Cluster    = local.name
    GithubRepo = "cucumber"
    GithubOrg  = "alleaffengaffen"
  }

  ### Don't edit the locals below
  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
    instance_metadata_tags      = "disabled"
  }
  iam_role_additional_policies = {
    AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    AmazonSSMManagedInstanceCore       = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
  block_device_mappings = {
    xvda = {
      device_name = "/dev/xvda"
      ebs = {
        volume_size           = 30
        volume_type           = "gp3"
        delete_on_termination = true
      }
    }
  }
}