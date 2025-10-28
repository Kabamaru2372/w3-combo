output "single_ip" {
  value       = try(aws_instance.app_single[0].public_ip, null)
  description = "Public IP for milestone 1 single instance"
}

output "app_ips" {
  value       = [for i in aws_instance.app : i.public_ip]
  description = "App server IPs for milestone 2/3"
}

output "lb_ip" {
  value       = try(aws_instance.lb[0].public_ip, null)
  description = "Load balancer IP for milestone 3"
}

output "app_names" {
  value = [for i in aws_instance.app : i.tags.Name]
}

output "app_ids" {
  value = [for i in aws_instance.app : i.tags.app_id]
}
