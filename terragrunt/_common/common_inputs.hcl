# Common TF Inputs - Will be exposed directly as TF variables
locals {
  confluent_api_key_secret_name = "${upper(get_env("CLOUD_PROVIDER"))}-CC-API-KEY-APP-${upper(get_env("ENV"))}"
  confluent_api_secret_secret_name = "${upper(get_env("CLOUD_PROVIDER"))}-CC-API-SECRET-APP-${upper(get_env("ENV"))}"

  cc_kafka_api_key_secret_name = "${upper(get_env("CLOUD_PROVIDER"))}-CC-KAFKA-API-KEY-APP-${upper(get_env("ENV"))}"
  cc_kafka_api_secret_secret_name = "${upper(get_env("CLOUD_PROVIDER"))}-CC-KAFKA-API-SECRET-APP-${upper(get_env("ENV"))}"

  cc_sr_api_key_secret_name = "${upper(get_env("CLOUD_PROVIDER"))}-CC-SR-API-KEY-APP-${upper(get_env("ENV"))}"
  cc_sr_api_secret_secret_name = "${upper(get_env("CLOUD_PROVIDER"))}-CC-SR-API-SECRET-APP-${upper(get_env("ENV"))}"
}

inputs = {
  confluent_api_key    =  (
                            get_env("CONFLUENT_API_KEY", "") != "" ? get_env("CONFLUENT_API_KEY") :
                            # If using Azure, pull secret from Key Vault using az cli, use regex to remove quotes from output
                            get_env("CLOUD_PROVIDER", "") == "azure" ? regex("^.(.*).$", run_cmd("--terragrunt-quiet", "az", "keyvault", "secret", "show", "--name", local.confluent_api_key_secret_name, "--vault-name", get_env("AZURE_KEYVAULT_NAME"), "--query", "value"))[0] :
                            ""
                          )
  confluent_api_secret =  (
                            get_env("CONFLUENT_API_SECRET", "") != "" ? get_env("CONFLUENT_API_SECRET") :
                            get_env("CLOUD_PROVIDER", "") == "azure" ? regex("^.(.*).$", run_cmd("--terragrunt-quiet", "az", "keyvault", "secret", "show", "--name", local.confluent_api_secret_secret_name, "--vault-name", get_env("AZURE_KEYVAULT_NAME"), "--query", "value"))[0] :
                            ""
                          )

  cc_kafka_api_key     =  (
                            get_env("CC_KAFKA_API_KEY", "") != "" ? get_env("CC_KAFKA_API_KEY") :
                            get_env("CLOUD_PROVIDER") == "azure" ? regex("^.(.*).$", run_cmd("--terragrunt-quiet", "az", "keyvault", "secret", "show", "--name", local.cc_kafka_api_key_secret_name, "--vault-name", get_env("AZURE_KEYVAULT_NAME"), "--query", "value"))[0] :
                            ""
                          )
  cc_kafka_api_secret  =  (
                            get_env("CC_KAFKA_API_SECRET", "") != "" ? get_env("CC_KAFKA_API_SECRET") :
                            get_env("CLOUD_PROVIDER") == "azure" ? regex("^.(.*).$", run_cmd("--terragrunt-quiet", "az", "keyvault", "secret", "show", "--name", local.cc_kafka_api_secret_secret_name, "--vault-name", get_env("AZURE_KEYVAULT_NAME"), "--query", "value"))[0] :
                            ""
                          )

  cc_sr_api_key        =  (
                            get_env("CC_SR_API_KEY", "") != "" ? get_env("CC_SR_API_KEY") :
                            get_env("CLOUD_PROVIDER") == "azure" ? regex("^.(.*).$", run_cmd("--terragrunt-quiet", "az", "keyvault", "secret", "show", "--name", local.cc_sr_api_key_secret_name, "--vault-name", get_env("AZURE_KEYVAULT_NAME"), "--query", "value"))[0] :
                            ""
                          )
  cc_sr_api_secret     =  (
                            get_env("CC_SR_API_SECRET", "") != "" ? get_env("CC_SR_API_SECRET") :
                            get_env("CLOUD_PROVIDER") == "azure" ? regex("^.(.*).$", run_cmd("--terragrunt-quiet", "az", "keyvault", "secret", "show", "--name", local.cc_sr_api_secret_secret_name, "--vault-name", get_env("AZURE_KEYVAULT_NAME"), "--query", "value"))[0] :
                            ""
                          )

  cc_sr_endpoint       = get_env("CC_SR_ENDPOINT")
  environment_name     = get_env("ENVIRONMENT_NAME")
  env_category         = get_env("ENV_CATEGORY")
  cc_kafka_cluster_name= get_env("CC_KAFKA_CLUSTER_NAME")
}


generate "shared_variables" {
  path      = "shared-variables.tf"
  if_exists = "overwrite"
  contents  = file("shared_variables.tf")
}