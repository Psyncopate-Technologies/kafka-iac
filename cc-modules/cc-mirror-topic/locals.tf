locals {
  mirror_topic_config = yamldecode(var.mirror_topic_config_raw)

  mirror_topics = local.mirror_topic_config["mirror_topics"]
}
