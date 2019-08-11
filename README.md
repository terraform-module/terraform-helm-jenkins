# Jenkins Helm Module

## Usage example

Here's the gist of using it via github.

```terraform
data helm_repository stable {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

module jenkins {
  source     = "git@github.com:terraform-helm-module/jenkins?ref=v0.2.0"
  namespace  = "jenkins"
  apps       = var.apps
  repository = data.helm_repository.stable.metadata.0.name
}
```

`varialbes.tfvars`
```terraform
apps = {
  jenkins = {
    name          = "jenkins"
    version       = "1.5.0"
    chart         = "stable/jenkins"
    force_update  = "true"
    wait          = "false"
    recreate_pods = "true"
    deploy        = 1

    values = [<<EOF
persistence:
  enabled: true
  size: "4Gi"
EOF
    ]
  }
}
```



## Module Variables

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| apps | Multiple applications to deploy | map | n/a | yes |
| namespace | Namespace to where deploy CI/CD | string | n/a | yes |
| repository | Collection of Helm repositories | string | n/a | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## How to Contribute

<!-- START makefile-doc -->
```
$ make help
hooks                          Commit hooks setup
validate                       Validate with pre-commit hooks
release                        Create release version
```
<!-- END makefile-doc -->