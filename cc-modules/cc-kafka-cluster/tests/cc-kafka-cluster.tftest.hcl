mock_provider "confluent" {
    mock_data "confluent_environment" {
        defaults = {
            id = "env-y6j90j"
        }
    }

    mock_data "confluent_network" {
        defaults = {
            id = "n-gqn40o"
        }
    }
}

# Default test variables, specific variables overwritten by individual tests
variables {
        confluent_cloud_environment_name = "azu-env-d-eastus2-01"
        confluent_cloud_network_name     = "azu-net-d-eastus2-01"

        cloud_provider = "AZURE"
        cloud_region = "eastus2"

        cluster_number = 1
        environment_name = "dev"

        cluster_multi_zone_available = false
        cluster_ckus = 1
}

# Cluster naming convention conformance tests
run "create_standard_named_cluster" {
    command = plan

    variables {
        cloud_provider = "AZURE"
        cloud_region = "eastus2"

        cluster_number = 1
        environment_name = "dev"
    }

    assert {
        condition = confluent_kafka_cluster.this.display_name == "azu-clstr-d-eastus2-01"
        error_message = "Cluster is expected follow CCOE cluster naming convention"
    }
}

# Cluster CKUs setup tests
run "create_specific_cku_cluster" {
    command = plan

    variables {
        cluster_ckus = 5
    }

    assert {
        condition = confluent_kafka_cluster.this.dedicated[0].cku == 5
        error_message = "Cluster is expected to have 5 CKUs"
    }
}
run "create_single_cku_multi_zone_cluster" {
    command = plan

    variables {
        cluster_multi_zone_available = true
        cluster_ckus = 1
    }

    expect_failures = [ var.cluster_ckus ]
}
run "create_invalid_cku_cluster" {
    command = plan

    variables {
        cluster_ckus = 0
    }

    expect_failures = [ var.cluster_ckus ]
}

# Cluster availability zone setup tests
run "create_single_zone_cluster" {
    command = plan

    variables {
        cluster_multi_zone_available = false
        cluster_ckus = 1
    }

    assert {
        condition = confluent_kafka_cluster.this.availability == "SINGLE_ZONE"
        error_message = "Cluster is expected to be single availability zone cluster"
    }
}
run "create_multi_zone_cluster" {
    command = plan

    variables {
        cluster_multi_zone_available = true
        cluster_ckus = 2
    }

    assert {
        condition = confluent_kafka_cluster.this.availability == "MULTI_ZONE"
        error_message = "Cluster is expected to be multi availability zone cluster"
    }
}

# Cluster cloud provider and region setup tests
run "create_azure_cluster" {
    command = plan

    variables {
        cloud_provider = "AZURE"
        cloud_region = "eastus2"
    }

    assert {
        condition = substr(confluent_kafka_cluster.this.display_name, 0, 3) == "azu"
        error_message = "Cluster name prefix is expected to be 'azu'"
    }
    assert {
        condition = split("-", confluent_kafka_cluster.this.display_name)[3] == "eastus2"
        error_message = "Cluster name is expected to have 'eastus2' region"
    }
    assert {
        condition = confluent_kafka_cluster.this.cloud == "AZURE" && confluent_kafka_cluster.this.region == "eastus2"
        error_message = "Cluster is expected to be in Azure eastus2"
    }
}
run "create_aws_cluster" {
    command = plan

    variables {
        confluent_cloud_environment_name = "aws-env-d-us-east-2-01"
        confluent_cloud_network_name     = "aws-net-d-us-east-2-01"

        cloud_provider = "AWS"
        cloud_region = "us-east-2"
    }

    assert {
        condition = substr(confluent_kafka_cluster.this.display_name, 0, 3) == "aws"
        error_message = "Cluster name prefix is expected to be 'aws'"
    }
    assert {
        condition = strcontains(confluent_kafka_cluster.this.display_name, "us-east-2")
        error_message = "Cluster name is expected to have 'us-east-2' region"
    }
    assert {
        condition = confluent_kafka_cluster.this.cloud == "AWS" && confluent_kafka_cluster.this.region == "us-east-2"
        error_message = "Cluster is expected to be in AWS us-east-2"
    }
}
run "create_gcp_cluster" {
    command = plan

    variables {
        confluent_cloud_environment_name = "gcp-env-d-us-east-5-01"
        confluent_cloud_network_name     = "gcp-net-d-us-east-5-01"

        cloud_provider = "GCP"
        cloud_region = "us-east-5"
    }

    assert {
        condition = substr(confluent_kafka_cluster.this.display_name, 0, 3) == "gcp"
        error_message = "Cluster name prefix is expected to be 'gcp'"
    }
    assert {
        condition = strcontains(confluent_kafka_cluster.this.display_name, "us-east-5")
        error_message = "Cluster name is expected to have 'us-east-5' region"
    }
    assert {
        condition = confluent_kafka_cluster.this.cloud == "GCP" && confluent_kafka_cluster.this.region == "us-east-5"
        error_message = "Cluster is expected to be in GCP us-east-5"
    }
}
run "create_invalid_cloud_cluster" {
    command = plan

    variables {
        cloud_provider = "INVALID"
    }

    expect_failures = [ var.cloud_provider ]
}

# Cluster environment name setup tests
run "create_dev_cluster" {
    command = plan

    variables {
        confluent_cloud_environment_name = "azu-env-d-eastus2-01"
        confluent_cloud_network_name     = "azu-net-d-eastus2-01"

        environment_name = "dev"
    }

    assert {
        condition = split("-", confluent_kafka_cluster.this.display_name)[2] == "d"
        error_message = "Cluster environment in name is expected to be 'd'"
    }
}
run "create_test_cluster" {
    command = plan

    variables {
        confluent_cloud_environment_name = "azu-env-t-eastus2-01"
        confluent_cloud_network_name     = "azu-net-t-eastus2-01"

        environment_name = "test"
    }

    assert {
        condition = split("-", confluent_kafka_cluster.this.display_name)[2] == "t"
        error_message = "Cluster environment in name is expected to be 't'"
    }
}
run "create_prod_cluster" {
    command = plan

    variables {
        confluent_cloud_environment_name = "azu-env-p-eastus2-01"
        confluent_cloud_network_name     = "azu-net-p-eastus2-01"

        environment_name = "prod"
    }

    assert {
        condition = split("-", confluent_kafka_cluster.this.display_name)[2] == "p"
        error_message = "Cluster environment in name is expected to be 'p'"
    }
}
run "create_invalid_env_cluster" {
    command = plan

    variables {
        environment_name = "INVALID"
    }

    expect_failures = [ var.environment_name ]
}

# Cluster Confluent Cloud environment & network validation tests
run "create_cluster_non_matching_envs" {
    command = plan

    variables {
        confluent_cloud_environment_name = "azu-env-d-eastus2-01"
        confluent_cloud_network_name     = "azu-net-d-eastus2-01"

        environment_name = "prod"
    }

    expect_failures = [ var.confluent_cloud_environment_name, var.confluent_cloud_network_name ]
}
run "create_cluster_non_matching_clouds" {
    command = plan

    variables {
        confluent_cloud_environment_name = "azu-env-d-eastus2-01"
        confluent_cloud_network_name     = "azu-net-d-eastus2-01"

        cloud_provider = "GCP"
    }

    expect_failures = [ var.confluent_cloud_environment_name, var.confluent_cloud_network_name ]
}
run "create_cluster_non_matching_regions" {
    command = plan

    variables {
        confluent_cloud_environment_name = "azu-env-d-eastus2-01"
        confluent_cloud_network_name     = "azu-net-d-eastus2-01"

        cloud_region = "centralus"
    }

    expect_failures = [ var.confluent_cloud_environment_name, var.confluent_cloud_network_name ]
}
run "create_cluster_invalid_cc_env_name" {
    command = plan

    variables {
        confluent_cloud_environment_name = "INVALID"
    }

    expect_failures = [ var.confluent_cloud_environment_name ]
}
run "create_cluster_invalid_cc_network_name" {
    command = plan

    variables {
        confluent_cloud_network_name = "INVALID"
    }

    expect_failures = [ var.confluent_cloud_network_name ]
}

# Cluster number suffix validation tests
run "create_valid_number_cluster" {
    command = plan

    variables {
        cluster_number = 2
    }

    assert {
        condition = endswith(confluent_kafka_cluster.this.display_name, "02")
        error_message = "Cluster name is expected to end with '02'"
    }
}
run "create_invalid_number_cluster" {
    command = plan

    variables {
        cluster_number = 0
    }

    expect_failures = [ var.cluster_number ]
}