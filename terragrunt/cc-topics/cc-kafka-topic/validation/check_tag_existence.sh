#!/usr/bin/env bash
set -eo pipefail

# Input arguments
CC_SR_API_KEY="$1"
CC_SR_API_SECRET="$2"
CC_SR_ENDPOINT="$3"
CLIENT_MAL="$4"
CLIENT_SRB="$5"
CLIENT_SEC="$6"

TAG_FILE="tag_override.auto.tfvars"
AUTH="${CC_SR_API_KEY}:${CC_SR_API_SECRET}"
SR_URL="${CC_SR_ENDPOINT}"

# Validate required arguments
for var in CC_SR_API_KEY CC_SR_API_SECRET CC_SR_ENDPOINT CLIENT_MAL CLIENT_SRB; do
  if [ -z "${!var}" ]; then
    echo "::error::Missing required argument: $var"
    exit 1
  fi
done

# Initialize tag entries: name|terraform_var_name|optional_flag
TAG_ENTRIES=(
  "$CLIENT_MAL|MAL|required"
  "$CLIENT_SRB|SRB|required"
)

if [ -n "$CLIENT_SEC" ]; then
  TAG_ENTRIES+=("$CLIENT_SEC|SEC|optional")
else
  echo "No SEC tag provided; skipping creation and binding."
  create_sec_tag=true
  apply_sec_binding=false
  CLIENT_SEC="null"
fi

# Functions
check_tag_in_cc() {
  local tag="$1"
  curl -s -u "$AUTH" "$SR_URL/catalog/v1/types/tagdefs/$tag" | jq -e '.name' >/dev/null 2>&1
}

check_tag_in_tf_state() {
  local tag="$1"
  while read -r res; do
    local tag_name
    tag_name=$(terragrunt state show "$res" 2>/dev/null | awk -F'=' '/^\s*name\s*=/{gsub(/"/,""); print $2}' | xargs)
    if [[ "$tag_name" == "$tag" ]]; then
      return 0
    fi
  done < <(terragrunt state list 2>/dev/null | grep -E '^confluent_tag(\.|$)')

  return 1
}

# Evaluate all tags
for entry in "${TAG_ENTRIES[@]}"; do
  IFS='|' read -r tag tag_key optional_flag <<< "$entry"
  echo -e "\nEvaluating tag: $tag (key: $tag_key)"

  TAG_IN_CC=false
  TAG_IN_STATE=false

  if check_tag_in_cc "$tag"; then
    echo "Found in Confluent Cloud"
    TAG_IN_CC=true
  else
    echo "Not found in Confluent Cloud"
  fi

  if check_tag_in_tf_state "$tag"; then
    echo "Found in Terraform state"
    TAG_IN_STATE=true
  else
    echo "Not found in Terraform state"
  fi

  # Matrix logic
  lower_key=$(echo "$tag_key" | tr '[:upper:]' '[:lower:]')

  if [[ "$TAG_IN_CC" == "true" && "$TAG_IN_STATE" == "false" ]]; then
    eval "create_${lower_key}_tag=false"
    echo "Setting create_${lower_key}_tag = false"
  else
    eval "create_${lower_key}_tag=true"
    echo "Setting create_${lower_key}_tag = true"
  fi


  # Special handling for SEC
  if [[ "$tag_key" == "SEC" ]]; then
    apply_sec_binding=true
  fi
done

# Write output tfvars
cat <<EOF > "$TAG_FILE"
create_mal_tag = ${create_mal_tag:-false}
create_srb_tag = ${create_srb_tag:-false}
create_sec_tag = ${create_sec_tag:-false}
apply_sec_binding = ${apply_sec_binding:-false}
EOF

echo -e "\nWrote $TAG_FILE with tag creation flags"
