output "releases" {
  value       = helm_release.chart[*]
  description = "Helm release attributes created by this module"
}
