resource "helm_release" "chart" {
  for_each = var.charts

  name                = try(each.value.name, each.key)
  repository          = each.value.repository
  repository_username = try(each.value.repository_username, "")
  repository_password = try(each.value.repository_password, "")
  chart               = try(each.value.chart, each.key)
  version             = each.value.version
  namespace           = try(each.value.namespace, each.key)
  wait                = try(each.value.wait, true)
  cleanup_on_fail     = try(each.value.cleanup_on_fail, true)
  atomic              = try(each.value.atomic, true)
  timeout             = try(each.value.timeout, 180)
  create_namespace    = try(each.value.create_namespace, true)
  dependency_update   = try(each.value.dependency_update, false)
  force_update        = try(each.value.force_update, false)
  lint                = try(each.value.lint, false)
  recreate_pods       = try(each.value.recreate_pods, false)
  reset_values        = try(each.value.reset_values, false)
  reuse_values        = try(each.value.reuse_values, false)
  skip_crds           = try(each.value.skip_crds, false)
  verify              = try(each.value.verify, false)

  values = try(each.value.values, false) || try(each.value.values_file_vars, false) != false ? [try(each.value.values, templatefile("${var.values_path}/${each.key}/values.yaml", each.value.values_file_vars))] : []

  dynamic "set" {
    for_each = try(each.value.sets, [])
    iterator = set

    content {
      name  = set.value.name
      value = set.value.value
    }
  }

  dynamic "set_list" {
    for_each = try(each.value.set_list, [])
    iterator = set_list

    content {
      name  = set_list.value.name
      value = set_list.value.value
    }
  }

  dynamic "set_sensitive" {
    for_each = try(each.value.set_sensitive, [])
    iterator = set_sensitive

    content {
      name  = set_sensitive.value.name
      value = set_sensitive.value.value
    }
  }

  dynamic "postrender" {
    for_each = try(each.value.postrender, [])
    iterator = postrender

    content {
      binary_path = postrender.value.binary_path
      args        = try(postrender.value.args, [])
    }
  }

}
