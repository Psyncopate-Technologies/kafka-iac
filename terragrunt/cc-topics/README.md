# TF module for CC Kafka Topics - YAML Interface approach

### Export the following TF variables
export CLOUD_PROVIDER=azure
export ENV=dev
export CONFLUENT_API_KEY=<CC API Key>
export CONFLUENT_API_SECRET=<CC API Secret>
export KAFKA_API_KEY=<Kafka Cluster API Key>
export KAFKA_API_SECRET=<Kafka Cluster API Secret>
export KAFKA_CLUSTER_ID=<Kafka Cluster ID>
export KAFKA_REST_ENDPOINT=<Kafka Cluster Rest Endpoint>
export DEFAULT_PATITION_COUNT=3

### Cloud Provider Specific Configurations
#### Azure - For state file storage
export AZURE_RESOURCE_GROUP_NAME=<Azure RG Name>
export AZURE_STORAGE_ACCOUNT_NAME=<Azure Blob storage account name>
export AZURE_STORAGE_CONTAINER_NAME=<Azure Blob container name>

#### Azure - Authentication to Azure to connect to Storage Account
export ARM_CLIENT_ID=<Azure SP Client ID>
export ARM_CLIENT_SECRET=<Aure SP Client Secret>
export ARM_TENANT_ID=<Azure Tenant ID>
export ARM_SUBSCRIPTION_ID=<Azure Tenant Subscription ID>

### Local Testing 
1. Place the YAML interface file for topic in the same directory as terragrunt.hcl
export FILE_NAME=sample_topic_files/TopicAlias1.yaml

### Execution for Local test
1. Navigate to the directory where `terragrun.hcl` file for cc-topics are available.
2. Ensure the YAML file holding the topic metadata resides in the same directory
3. Run `terragrunt init`
4. Run `terragrunt plan`
5. Run `terragrunt apply --auto-approve`