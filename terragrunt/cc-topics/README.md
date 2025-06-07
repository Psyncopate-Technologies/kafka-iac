# TF module for CC Kafka Topics - YAML Interface approach

### Export the following TF variables
1. `export CLOUD_PROVIDER=azure`
2. `export ENV=dev`
3. `export CONFLUENT_API_KEY=<CC API Key>`
4. `export CONFLUENT_API_SECRET=<CC API Secret>`
5. `export CC_KAFKA_API_KEY=<Kafka Cluster API Key>`
6. `export CC_KAFKA_API_SECRET=<Kafka Cluster API Secret>`
7. `export CC_KAFKA_CLUSTER_NAME=<Kafka Cluster Name>`
7. `export ENVIRONMENT_NAME=<Confluent Cloud Environment Name>`
9. `export DEFAULT_PATITION_COUNT=3`
10. `export GITHUB_TOKEN=<Github Token>`

### Cloud Provider Specific Configurations
#### Azure - For state file storage
1. `export AZURE_RESOURCE_GROUP_NAME=<Azure RG Name>`
2. `export AZURE_STORAGE_ACCOUNT_NAME=<Azure Blob storage account name>`
3. `export AZURE_STORAGE_CONTAINER_NAME=<Azure Blob container name>`

#### Azure - Authentication to Azure to connect to Storage Account
1. `export ARM_CLIENT_ID=<Azure SP Client ID>`
2. `export ARM_CLIENT_SECRET=<Aure SP Client Secret>`
3. `export ARM_TENANT_ID=<Azure Tenant ID>`
4. `export ARM_SUBSCRIPTION_ID=<Azure Tenant Subscription ID>`

### Local Testing 
1. Place the YAML interface file for topic in the same directory as terragrunt.hcl
`export FILE_NAME=sample_topic_files/TopicAlias1.yaml`

### Execution for Local test
1. Navigate to the directory where `terragrun.hcl` file for cc-topics are available.
2. Ensure the YAML file holding the topic metadata resides in the same directory
3. Run `terragrunt init`
4. Run `terragrunt plan`
5. Run `terragrunt apply --auto-approve`