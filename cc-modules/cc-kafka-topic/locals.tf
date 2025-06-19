locals {
  topic_config = var.topic_config_raw
  topic        = local.topic_config.topic
  partitions_count = try(local.topic.partitions, var.default_partitions)
  topic_config_map = try(local.topic.config, null)

  # Optional 'retention' field (e.g. "5s", "3m", "2h", "1d")
  raw_retention = try(local.topic.retention, null)

  # Retention in milliseconds (only if defined)
  retention_ms = local.raw_retention == null ? null : (
    can(regex("^\\d+s$", local.raw_retention)) ? tonumber(regexall("^\\d+", local.raw_retention)[0]) * 1000 :
    can(regex("^\\d+m$", local.raw_retention)) ? tonumber(regexall("^\\d+", local.raw_retention)[0]) * 60 * 1000 :
    can(regex("^\\d+h$", local.raw_retention)) ? tonumber(regexall("^\\d+", local.raw_retention)[0]) * 60 * 60 * 1000 :
    can(regex("^\\d+d$", local.raw_retention)) ? tonumber(regexall("^\\d+", local.raw_retention)[0]) * 24 * 60 * 60 * 1000 :
    null
  )

  # Cleanup policy optional field
  cleanup_policy = try(local.topic.cleanup_policy, null)

  # Final config: merge user-supplied config with calculated retention.ms (if defined)
  final_config = merge(
    local.topic_config_map,
    local.retention_ms == null ? {} : { "retention.ms" = tostring(local.retention_ms) },
    local.cleanup_policy == null ? {} : { "cleanup.policy" = tostring(local.cleanup_policy) }
  )
}