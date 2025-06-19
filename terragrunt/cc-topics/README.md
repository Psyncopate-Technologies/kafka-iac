# TF Module for Confluent Cloud Kafka Topics — YAML Interface Approach

This Terragrunt wrapper provisions **Kafka Topics** in **Confluent Cloud** using a **YAML interface**, abstracting away Terraform complexity while enforcing governance via naming conventions, metadata, and hooks.

---

## Overview

This wrapper uses a topic-specific YAML file to define Kafka topic configurations and dynamically injects those values into a reusable Terraform module sourced from:

```hcl
git::https://github.com/Psyncopate-Technologies/kafka-iac.git//cc-modules/cc-kafka-topic?ref=<version>
```

- `pipeline_version` is fetched from the YAML (`default = latest`)
- Works across **Azure**, **AWS**, and **GCP** for backend state
- Pre-provisioning hooks ensure SRB and MAL compliance

---

## Required Environment Variables

### Common

| Variable                   | Description                                 |
|---------------------------|---------------------------------------------|
| `CLOUD_PROVIDER`          | Cloud where backend is stored (`azure`, etc.) |
| `ENV`                     | Environment (`dev`, `test`, `prod`)         |
| `CONFLUENT_API_KEY`       | Confluent Cloud API Key                     |
| `CONFLUENT_API_SECRET`    | Confluent Cloud API Secret                  |
| `CC_KAFKA_API_KEY`        | Kafka API Key                               |
| `CC_KAFKA_API_SECRET`     | Kafka API Secret                            |
| `CC_KAFKA_CLUSTER_NAME`   | Kafka Cluster Name                          |
| `ENVIRONMENT_NAME`        | Confluent Cloud Environment Name            |
| `DEFAULT_PATITION_COUNT`  | Default number of partitions (e.g., `3`)    |
| `GITHUB_TOKEN`            | Token to access the private module repo     |
| `CC_SR_API_KEY`           | Schema Registry API Key                     |
| `CC_SR_API_SECRET`        | Schema Registry API Secret                  |
| `CC_SR_ENDPOINT`          | Schema Registry endpoint                    |
| `FILE_NAME`               | Path to the YAML file describing the topic  |

---

### Azure Backend (State Storage)

| Variable                     | Description                           |
|-----------------------------|---------------------------------------|
| `AZURE_RESOURCE_GROUP_NAME` | Azure Resource Group name             |
| `AZURE_STORAGE_ACCOUNT_NAME`| Azure Storage Account for state       |
| `AZURE_STORAGE_CONTAINER_NAME` | Azure Blob Container for state     |

### Azure Authentication

| Variable               | Description                |
|------------------------|----------------------------|
| `ARM_CLIENT_ID`        | Azure SP Client ID         |
| `ARM_CLIENT_SECRET`    | Azure SP Client Secret     |
| `ARM_TENANT_ID`        | Azure Tenant ID            |
| `ARM_SUBSCRIPTION_ID`  | Azure Subscription ID      |


---

## YAML File Format

The YAML should include topic metadata like:

- `pipeline_version`
- `topic.name`
- `topic.alias_name`
- `mal_acronym`
- `srb_review_number`

This file is passed via:
```bash
export FILE_NAME=sample_topic_files/TopicAlias1.yaml
```

Only one topic definition is expected per file.

---

## Pre-Apply Validation Hook

Before `plan` or `apply`, the following script validates the SRB and MAL fields:

```bash
validation/check_tag_existence.sh \
  $CC_SR_API_KEY \
  $CC_SR_API_SECRET \
  $CC_SR_ENDPOINT \
  <clientMAL> \
  <srb_review_number>
```

---

## Local Testing Instructions

1. Place the topic YAML file in the same directory as `terragrunt.hcl`
2. Export all required environment variables
3. Run the following commands:

```bash
terragrunt init
terragrunt plan
terragrunt apply --auto-approve
```

---

## Generated Outputs

| Output Name         | Description                                    |
|---------------------|------------------------------------------------|
| `pipeline_version`  | The version of the IaC module that was applied |
| `topic_id`          | The Confluent Kafka topic ID that was created  |

---

## Notes

- The backend is dynamically created using the environment and alias name:
  ```
  <ENV>/topics/<alias_name>.tfstate
  ```
- If `pipeline_version` is not defined in the YAML, `latest` is used.
- The reusable module validates the topic name and enforces naming conventions via Terraform `variables.tf`.

---
