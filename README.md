# cucumber

Terraform code to stage AWS EKS cluster

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
