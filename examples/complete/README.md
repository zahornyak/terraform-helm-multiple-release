```hcl
module "releases" {
  source = "../../"

  charts = {
    nginx = {
      repository = "https://charts.bitnami.com/bitnami"
      version    = "18.2.0"
      namespace  = "default"
      values_file_vars = {
        tag = "latest"
      }
    }


    nginx2 = {
      repository = "https://charts.bitnami.com/bitnami"
      version    = "18.2.0"
      namespace  = "default"
      chart      = "nginx"
      sets = [
        {
          name  = "image.tag"
          value = "latest"
        },
        {
          name  = "readinessProbe.enabled"
          value = "true"
        }
      ]
      set_list = [
        {
          name  = "example.tags"
          value = ["latest", "example"]
        },
        {
          name  = "example.envs"
          value = ["prod", "staging"]
        }
      ]
      set_sensitive = [
        {
          name  = "example.password"
          value = "password"
        }
      ]
    }
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_releases"></a> [releases](#module\_releases) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
