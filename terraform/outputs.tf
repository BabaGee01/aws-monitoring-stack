output "monitoring_server_ip" {
  description = "Public IP of the monitoring EC2 instance"
  value       = module.ec2.public_ip
}

output "prometheus_url" {
  description = "Prometheus UI URL"
  value       = "http://${module.ec2.public_ip}:9090"
}

output "grafana_url" {
  description = "Grafana UI URL"
  value       = "http://${module.ec2.public_ip}:3000"
}