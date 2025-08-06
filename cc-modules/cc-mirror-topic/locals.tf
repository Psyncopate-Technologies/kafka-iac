locals {
  mirror_topic = yamldecode(var.mirror_topic_config_raw)
}
