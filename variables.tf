variable "ecs_capacity_providers" {
  description = <<EOT
Map of ecs_capacity_providers, attributes below
Required:
    - name
Optional:
    - cluster
    - region
    - tags
    - tags_all
    - auto_scaling_group_provider (block):
        - auto_scaling_group_arn (required)
        - managed_draining (optional)
        - managed_scaling (optional, block):
            - instance_warmup_period (optional)
            - maximum_scaling_step_size (optional)
            - minimum_scaling_step_size (optional)
            - status (optional)
            - target_capacity (optional)
        - managed_termination_protection (optional)
    - managed_instances_provider (block):
        - infrastructure_optimization (optional, block):
            - scale_in_after (optional)
        - infrastructure_role_arn (required)
        - instance_launch_template (required, block):
            - capacity_option_type (optional)
            - capacity_reservations (optional, block):
                - reservation_group_arn (optional)
                - reservation_preference (optional)
            - ec2_instance_profile_arn (required)
            - instance_requirements (optional, block):
                - accelerator_count (optional, block):
                    - max (optional)
                    - min (optional)
                - accelerator_manufacturers (optional)
                - accelerator_names (optional)
                - accelerator_total_memory_mib (optional, block):
                    - max (optional)
                    - min (optional)
                - accelerator_types (optional)
                - allowed_instance_types (optional)
                - bare_metal (optional)
                - baseline_ebs_bandwidth_mbps (optional, block):
                    - max (optional)
                    - min (optional)
                - burstable_performance (optional)
                - cpu_manufacturers (optional)
                - excluded_instance_types (optional)
                - instance_generations (optional)
                - local_storage (optional)
                - local_storage_types (optional)
                - max_spot_price_as_percentage_of_optimal_on_demand_price (optional)
                - memory_gib_per_vcpu (optional, block):
                    - max (optional)
                    - min (optional)
                - memory_mib (required, block):
                    - max (optional)
                    - min (required)
                - network_bandwidth_gbps (optional, block):
                    - max (optional)
                    - min (optional)
                - network_interface_count (optional, block):
                    - max (optional)
                    - min (optional)
                - on_demand_max_price_percentage_over_lowest_price (optional)
                - require_hibernate_support (optional)
                - spot_max_price_percentage_over_lowest_price (optional)
                - total_local_storage_gb (optional, block):
                    - max (optional)
                    - min (optional)
                - vcpu_count (required, block):
                    - max (optional)
                    - min (required)
            - local_storage_configuration (optional, block):
                - use_local_storage (optional)
            - monitoring (optional)
            - network_configuration (required, block):
                - security_groups (optional)
                - subnets (required)
            - storage_configuration (optional, block):
                - storage_size_gib (required)
        - propagate_tags (optional)
EOT

  type = map(object({
    name     = string
    cluster  = optional(string)
    region   = optional(string)
    tags     = optional(map(string))
    tags_all = optional(map(string))
    auto_scaling_group_provider = optional(object({
      auto_scaling_group_arn = string
      managed_draining       = optional(string)
      managed_scaling = optional(object({
        instance_warmup_period    = optional(number)
        maximum_scaling_step_size = optional(number)
        minimum_scaling_step_size = optional(number)
        status                    = optional(string)
        target_capacity           = optional(number)
      }))
      managed_termination_protection = optional(string)
    }))
    managed_instances_provider = optional(object({
      infrastructure_optimization = optional(object({
        scale_in_after = optional(number)
      }))
      infrastructure_role_arn = string
      instance_launch_template = object({
        capacity_option_type = optional(string)
        capacity_reservations = optional(object({
          reservation_group_arn  = optional(string)
          reservation_preference = optional(string)
        }))
        ec2_instance_profile_arn = string
        instance_requirements = optional(object({
          accelerator_count = optional(object({
            max = optional(number)
            min = optional(number)
          }))
          accelerator_manufacturers = optional(set(string))
          accelerator_names         = optional(set(string))
          accelerator_total_memory_mib = optional(object({
            max = optional(number)
            min = optional(number)
          }))
          accelerator_types      = optional(set(string))
          allowed_instance_types = optional(set(string))
          bare_metal             = optional(string)
          baseline_ebs_bandwidth_mbps = optional(object({
            max = optional(number)
            min = optional(number)
          }))
          burstable_performance                                   = optional(string)
          cpu_manufacturers                                       = optional(set(string))
          excluded_instance_types                                 = optional(set(string))
          instance_generations                                    = optional(set(string))
          local_storage                                           = optional(string)
          local_storage_types                                     = optional(set(string))
          max_spot_price_as_percentage_of_optimal_on_demand_price = optional(number)
          memory_gib_per_vcpu = optional(object({
            max = optional(number)
            min = optional(number)
          }))
          memory_mib = object({
            max = optional(number)
            min = number
          })
          network_bandwidth_gbps = optional(object({
            max = optional(number)
            min = optional(number)
          }))
          network_interface_count = optional(object({
            max = optional(number)
            min = optional(number)
          }))
          on_demand_max_price_percentage_over_lowest_price = optional(number)
          require_hibernate_support                        = optional(bool)
          spot_max_price_percentage_over_lowest_price      = optional(number)
          total_local_storage_gb = optional(object({
            max = optional(number)
            min = optional(number)
          }))
          vcpu_count = object({
            max = optional(number)
            min = number
          })
        }))
        local_storage_configuration = optional(object({
          use_local_storage = optional(bool)
        }))
        monitoring = optional(string)
        network_configuration = object({
          security_groups = optional(set(string))
          subnets         = set(string)
        })
        storage_configuration = optional(object({
          storage_size_gib = number
        }))
      })
      propagate_tags = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.ecs_capacity_providers : (
        v.auto_scaling_group_provider == null || (v.auto_scaling_group_provider.managed_scaling == null || (v.auto_scaling_group_provider.managed_scaling.instance_warmup_period == null || (v.auto_scaling_group_provider.managed_scaling.instance_warmup_period >= 0 && v.auto_scaling_group_provider.managed_scaling.instance_warmup_period <= 10000)))
      )
    ])
    error_message = "must be between 0 and 10000"
  }
  validation {
    condition = alltrue([
      for k, v in var.ecs_capacity_providers : (
        v.auto_scaling_group_provider == null || (v.auto_scaling_group_provider.managed_scaling == null || (v.auto_scaling_group_provider.managed_scaling.maximum_scaling_step_size == null || (v.auto_scaling_group_provider.managed_scaling.maximum_scaling_step_size >= 1 && v.auto_scaling_group_provider.managed_scaling.maximum_scaling_step_size <= 10000)))
      )
    ])
    error_message = "must be between 1 and 10000"
  }
  validation {
    condition = alltrue([
      for k, v in var.ecs_capacity_providers : (
        v.auto_scaling_group_provider == null || (v.auto_scaling_group_provider.managed_scaling == null || (v.auto_scaling_group_provider.managed_scaling.minimum_scaling_step_size == null || (v.auto_scaling_group_provider.managed_scaling.minimum_scaling_step_size >= 1 && v.auto_scaling_group_provider.managed_scaling.minimum_scaling_step_size <= 10000)))
      )
    ])
    error_message = "must be between 1 and 10000"
  }
  validation {
    condition = alltrue([
      for k, v in var.ecs_capacity_providers : (
        v.auto_scaling_group_provider == null || (v.auto_scaling_group_provider.managed_scaling == null || (v.auto_scaling_group_provider.managed_scaling.target_capacity == null || (v.auto_scaling_group_provider.managed_scaling.target_capacity >= 1 && v.auto_scaling_group_provider.managed_scaling.target_capacity <= 100)))
      )
    ])
    error_message = "must be between 1 and 100"
  }
  validation {
    condition = alltrue([
      for k, v in var.ecs_capacity_providers : (
        v.managed_instances_provider == null || (v.managed_instances_provider.infrastructure_optimization == null || (v.managed_instances_provider.infrastructure_optimization.scale_in_after == null || (v.managed_instances_provider.infrastructure_optimization.scale_in_after >= -1 && v.managed_instances_provider.infrastructure_optimization.scale_in_after <= 3600)))
      )
    ])
    error_message = "must be between -1 and 3600"
  }
  validation {
    condition = alltrue([
      for k, v in var.ecs_capacity_providers : (
        v.managed_instances_provider == null || (v.managed_instances_provider.instance_launch_template.instance_requirements == null || (v.managed_instances_provider.instance_launch_template.instance_requirements.allowed_instance_types == null || (alltrue([for x in v.managed_instances_provider.instance_launch_template.instance_requirements.allowed_instance_types : (length(x) >= 1 && length(x) <= 30) && (can(regex("^[a-zA-Z0-9\\.\\*\\-]+$", x)))]))))
      )
    ])
    error_message = "all of: must be between 1 and 30 characters; must contain only alphanumeric characters, dots, asterisks, and hyphens"
  }
  validation {
    condition = alltrue([
      for k, v in var.ecs_capacity_providers : (
        v.managed_instances_provider == null || (v.managed_instances_provider.instance_launch_template.instance_requirements == null || (v.managed_instances_provider.instance_launch_template.instance_requirements.excluded_instance_types == null || (alltrue([for x in v.managed_instances_provider.instance_launch_template.instance_requirements.excluded_instance_types : (length(x) >= 1 && length(x) <= 30) && (can(regex("^[a-zA-Z0-9\\.\\*\\-]+$", x)))]))))
      )
    ])
    error_message = "all of: must be between 1 and 30 characters; must contain only alphanumeric characters, dots, asterisks, and hyphens"
  }
  validation {
    condition = alltrue([
      for k, v in var.ecs_capacity_providers : (
        v.managed_instances_provider == null || (v.managed_instances_provider.instance_launch_template.instance_requirements == null || (v.managed_instances_provider.instance_launch_template.instance_requirements.max_spot_price_as_percentage_of_optimal_on_demand_price == null || (v.managed_instances_provider.instance_launch_template.instance_requirements.max_spot_price_as_percentage_of_optimal_on_demand_price >= 0)))
      )
    ])
    error_message = "must be at least 0"
  }
  validation {
    condition = alltrue([
      for k, v in var.ecs_capacity_providers : (
        v.managed_instances_provider == null || (v.managed_instances_provider.instance_launch_template.instance_requirements == null || (v.managed_instances_provider.instance_launch_template.instance_requirements.on_demand_max_price_percentage_over_lowest_price == null || (v.managed_instances_provider.instance_launch_template.instance_requirements.on_demand_max_price_percentage_over_lowest_price >= 0)))
      )
    ])
    error_message = "must be at least 0"
  }
  validation {
    condition = alltrue([
      for k, v in var.ecs_capacity_providers : (
        v.managed_instances_provider == null || (v.managed_instances_provider.instance_launch_template.instance_requirements == null || (v.managed_instances_provider.instance_launch_template.instance_requirements.spot_max_price_percentage_over_lowest_price == null || (v.managed_instances_provider.instance_launch_template.instance_requirements.spot_max_price_percentage_over_lowest_price >= 0)))
      )
    ])
    error_message = "must be at least 0"
  }
  validation {
    condition = alltrue([
      for k, v in var.ecs_capacity_providers : (
        v.managed_instances_provider == null || (v.managed_instances_provider.instance_launch_template.storage_configuration == null || (v.managed_instances_provider.instance_launch_template.storage_configuration.storage_size_gib >= 1))
      )
    ])
    error_message = "must be at least 1"
  }
  # Note: 39 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

