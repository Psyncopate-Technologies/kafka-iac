include "common" {
  path = find_in_parent_folders("_common/common.hcl")
}
include "common_provider" {
  path = find_in_parent_folders("_common/provider.hcl")
}

# remote_state {
#   backend = "azurerm"
#   config = {
#     resource_group_name  = local.common_vars.resource_group_name
#     storage_account_name = "mytfstatestorage"
#     container_name       = "tfstate"
#     key                  = "${path_relative_to_include()}/terraform.tfstate"
#   }
# }

remote_state {
  backend = "local"
  config = {
    path = "${get_parent_terragrunt_dir()}/${path_relative_to_include()}/terraform.tfstate"
  }

  generate = {
    path = "backend.tf"
    if_exists = "overwrite"
  }
}
