output "ecs_capacity_providers_id" {
  description = "Map of id values across all ecs_capacity_providers, keyed the same as var.ecs_capacity_providers"
  value       = { for k, v in aws_ecs_capacity_provider.ecs_capacity_providers : k => v.id if v.id != null && length(v.id) > 0 }
}
output "ecs_capacity_providers_arn" {
  description = "Map of arn values across all ecs_capacity_providers, keyed the same as var.ecs_capacity_providers"
  value       = { for k, v in aws_ecs_capacity_provider.ecs_capacity_providers : k => v.arn if v.arn != null && length(v.arn) > 0 }
}
output "ecs_capacity_providers_auto_scaling_group_provider" {
  description = "Map of auto_scaling_group_provider values across all ecs_capacity_providers, keyed the same as var.ecs_capacity_providers"
  value       = { for k, v in aws_ecs_capacity_provider.ecs_capacity_providers : k => one(v.auto_scaling_group_provider) if v.auto_scaling_group_provider != null && length(v.auto_scaling_group_provider) > 0 }
}
output "ecs_capacity_providers_cluster" {
  description = "Map of cluster values across all ecs_capacity_providers, keyed the same as var.ecs_capacity_providers"
  value       = { for k, v in aws_ecs_capacity_provider.ecs_capacity_providers : k => v.cluster if v.cluster != null && length(v.cluster) > 0 }
}
output "ecs_capacity_providers_managed_instances_provider" {
  description = "Map of managed_instances_provider values across all ecs_capacity_providers, keyed the same as var.ecs_capacity_providers"
  value       = { for k, v in aws_ecs_capacity_provider.ecs_capacity_providers : k => one(v.managed_instances_provider) if v.managed_instances_provider != null && length(v.managed_instances_provider) > 0 }
}
output "ecs_capacity_providers_name" {
  description = "Map of name values across all ecs_capacity_providers, keyed the same as var.ecs_capacity_providers"
  value       = { for k, v in aws_ecs_capacity_provider.ecs_capacity_providers : k => v.name if v.name != null && length(v.name) > 0 }
}
output "ecs_capacity_providers_region" {
  description = "Map of region values across all ecs_capacity_providers, keyed the same as var.ecs_capacity_providers"
  value       = { for k, v in aws_ecs_capacity_provider.ecs_capacity_providers : k => v.region if v.region != null && length(v.region) > 0 }
}
output "ecs_capacity_providers_tags" {
  description = "Map of tags values across all ecs_capacity_providers, keyed the same as var.ecs_capacity_providers"
  value       = { for k, v in aws_ecs_capacity_provider.ecs_capacity_providers : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "ecs_capacity_providers_tags_all" {
  description = "Map of tags_all values across all ecs_capacity_providers, keyed the same as var.ecs_capacity_providers"
  value       = { for k, v in aws_ecs_capacity_provider.ecs_capacity_providers : k => v.tags_all if v.tags_all != null && length(v.tags_all) > 0 }
}

