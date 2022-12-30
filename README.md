# cucumber

Terraform code to stage an opiniated AWS EKS cluster

## Usage

- Fork the repo
- Edit the [locals.tf](./locals.tf) file to your likings
- Create a new TF workspace in an organization of your choice
  - set the following environment variables in the workspace:
    - `AWS_ACCESS_KEY_ID`
    - `AWS_SECRET_ACCESS_KEY`
  - make sure to use VCS driven workflow and point to the folder of the configuration you want to use

- Let the workspace run it's first plan

## Notes

**This code is not meant for production**

- All tools at least use the latest patch, if not the latest minor, the automatically upgrade itself
- The terraform runs aren't idempotent: each new run could upgrade an cluster addon or something else automatically (TF modules also use latest minor version)

## AWS IRSA

Since we're using AWS EKS, you can use IAM roles that service accounts in EKS can assume to communicate with AWS services. An example module for common controller policies can be found [here](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-role-for-service-accounts-eks).

### Usage

Here's an example that could serve as a starting point:

```hcl
module "vpc_cni_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name_prefix      = "VPC-CNI-IRSA"
  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv4   = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-node"]
    }
  }

  tags = local.tags
}
```
