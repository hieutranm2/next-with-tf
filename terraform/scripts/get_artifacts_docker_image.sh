#!/bin/bash
# Exit if any of the intermediate steps fail
# set -e

# Extract arguments from the input into
# `jq` will ensure that the values are properly quoted and escaped for consumption by the shell.
eval "$(jq -r '@sh "REGION=\(.region) PROJECT_ID=\(.project_id) REPO_ID=\(.repo_id) IMAGE_NAME=\(.image_name)"')"

# Use `gcloud` to list the images in the repository
EXISTING_IMAGE=$(gcloud artifacts docker images list \
    $REGION-docker.pkg.dev/$PROJECT_ID/$REPO_ID/$IMAGE_NAME \
    --sort-by="~UPDATE_TIME" \
    --format="value(package)" \
    --limit=1)

jq -n --arg self_link "$EXISTING_IMAGE" '{"self_link":$self_link}'
