# -----------------------------------------------
# Deploy Jenkins CI with Helm Chart
# -----------------------------------------------

locals {
  namespace = var.namespace
  jenkins   = var.apps["jenkins"]
}

terraform {
  # The modules used in this example have been updated with 0.12 syntax, which means the example is no longer
  # compatible with any versions below 0.12.
  required_version = ">= 0.12"
}

resource helm_release jenkins {
  count         = local.jenkins["deploy"]
  namespace     = local.namespace
  repository    = var.repository
  name          = local.jenkins["name"]
  version       = local.jenkins["version"]
  chart         = local.jenkins["chart"]
  force_update  = local.jenkins["force_update"]
  wait          = local.jenkins["wait"]
  recreate_pods = local.jenkins["recreate_pods"]
  values        = local.jenkins["values"]

  set_string {
    name  = "labels.kubernetes\\.io/name"
    value = "${local.jenkins["name"]}"
  }

  set_string {
    name  = "service.labels.kubernetes\\.io/name"
    value = "${local.jenkins["name"]}"
  }

  depends_on = [
    "kubernetes_namespace.this",
  ]
}

resource kubernetes_namespace this {
  metadata {
    name = var.namespace

    labels = {
      name        = var.namespace
      description = "continuous-integration-and-delivery"
    }
  }
}

output path {
  value = path.module
}
