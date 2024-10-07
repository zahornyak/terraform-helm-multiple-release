variable "charts" {
  description = "charts"
  type        = any
}

variable "values_path" {
  description = "Path to the values folder. For example: if `values/development/` and chart in `var.charts` is `nginx` then terraform will try to use `values/development/nginx.yaml`"
  type        = string
  default     = "values"
}
