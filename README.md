# cucumber

Terraform code to stage AWS EKS cluster

## Usage

This usage assumes:

- that you want to use Terraform Cloud

1. Fork the repo
2. Edit the [locals.tf](./locals.tf) file to your likings
3. Create a new TF workspace in an organization of your choice, set the following environment variables in the workspace:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

4. Let the workspace run it's first plan
