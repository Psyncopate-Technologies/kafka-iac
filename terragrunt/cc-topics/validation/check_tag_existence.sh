#!/usr/bin/env bash
set -eo pipefail

CC_SR_API_KEY="$1"
CC_SR_API_SECRET="$2"
CC_SR_ENDPOINT="$3"
CLIENT_MAL="$4"
CLIENT_SRB="$5"

# Validate input
for var in CC_SR_API_KEY CC_SR_API_SECRET CC_SR_ENDPOINT CLIENT_MAL CLIENT_SRB; do
  if [ -z "${!var}" ]; then
    echo "::error::Missing required argument: $var"
    exit 1
  fi
done

TAG_FILE="tag_override.auto.tfvars"
AUTH="${CC_SR_API_KEY}:${CC_SR_API_SECRET}"
SR_URL="${CC_SR_ENDPOINT}"

check_tag() {
  local tag_name="$1"
  if curl -s -u "$AUTH" "$SR_URL/catalog/v1/types/tagdefs/$tag_name" | jq -e '.name' >/dev/null 2>&1; then
    return 0
  else
    return 1
  fi
}

echo "Checking tag existence in..."

if check_tag "$CLIENT_MAL"; then
  echo "Tag '$CLIENT_MAL' exists."
  MAL_CREATE=false
else
  echo "Tag '$CLIENT_MAL' does not exist."
  MAL_CREATE=true
fi

if check_tag "$CLIENT_SRB"; then
  echo "Tag '$CLIENT_SRB' exists."
  SRB_CREATE=false
else
  echo "Tag '$CLIENT_SRB' does not exist."
  SRB_CREATE=true
fi

# Write tag override file for Terraform
cat <<EOF > "$TAG_FILE"
create_mal_tag = $MAL_CREATE
create_srb_tag = $SRB_CREATE
EOF

echo "Wrote $TAG_FILE with tag creation flags"
