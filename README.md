# Terraform Helm Multiple Release module
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/zahornyak/terraform-helm-multiple-release)

Terraform module that simplifies multiple helm releases creation. 


## Example usage

### Simple helm release
```hcl
module "this" {
  source = "zahornyak/multiple-release/helm"
  version = "x.x.x"

  charts = {
    nginx = {
      repository = "https://charts.bitnami.com/bitnami"
      version    = "18.2.0"
      namespace  = "default"
    }
  }
}
```


### Helm release with values
```hcl
module "this" {
  source = "zahornyak/multiple-release/helm"
  version = "x.x.x"

  charts = {
    nginx = {
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

### Helm release with values from file
```hcl
module "this" {
  source = "zahornyak/multiple-release/helm"
  version = "x.x.x"

  charts = {
    nginx = {
      repository = "https://charts.bitnami.com/bitnami"
      version    = "18.2.0"
      namespace  = "default"
      values_file_vars = {
        tag = "latest"
      }
    }
  }
}
```

`values/nginx.yaml`: (this path can be changed using `var.values_path`)
```yaml
image:
  tag: ${tag}
```

#### OR

```hcl
module "this" {
  source = "zahornyak/multiple-release/helm"
  version = "x.x.x"

  charts = {
    nginx = {
      repository = "https://charts.bitnami.com/bitnami"
      version    = "18.2.0"
      namespace  = "default"
      values = [
        "${file("values.yaml")}"
      ]
    }
  }
}
```
from [this example](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release#example-usage---chart-repository)


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.chart](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_charts"></a> [charts](#input\_charts) | charts | `any` | n/a | yes |
| <a name="input_values_path"></a> [values\_path](#input\_values\_path) | Path to the values folder. For example: if `values/development/` and chart in `var.charts` is `nginx` then terraform will try to use `values/development/nginx.yaml` | `string` | `"values"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_releases"></a> [releases](#output\_releases) | Helm release attributes created by this module |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
