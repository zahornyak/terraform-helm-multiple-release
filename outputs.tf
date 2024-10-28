output "releases" {
  value       = { for release in helm_release.chart : release.name => release }
  description = "Helm release attributes created by this module"
}
