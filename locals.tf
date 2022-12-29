locals {
  name            = "cucumber"
  cluster_version = "1.24"
  region          = "sa-east-1"

  vpc_cidr = "10.123.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Cluster    = local.name
    GithubRepo = "cucumber"
    GithubOrg  = "alleaffengaffen"
  }
}