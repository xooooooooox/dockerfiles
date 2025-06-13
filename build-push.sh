#!/bin/bash

# Script to build multi-platform Docker images and push them to a registry
# Usage: ./build-push.sh -d <dockerfile_dir> -t <tag1,tag2,...> [-p <platforms>]

set -e

# Default values
DOCKERFILE_DIR=""
TAGS=""
PLATFORMS="linux/amd64,linux/arm64"

# Parse command line arguments
while getopts "d:t:p:" opt; do
  case $opt in
    d) DOCKERFILE_DIR="$OPTARG" ;;
    t) TAGS="$OPTARG" ;;
    p) PLATFORMS="$OPTARG" ;;
    \?) echo "Invalid option -$OPTARG" >&2; exit 1 ;;
  esac
done

# Validate required parameters
if [ -z "$DOCKERFILE_DIR" ] || [ -z "$TAGS" ]; then
  echo "Error: Missing required parameters"
  echo "Usage: ./build-push.sh -d <dockerfile_dir> -t <tag1,tag2,...> [-p <platforms>]"
  echo "Example: ./build-push.sh -d alpine -t username/alpine:latest,username/alpine:20240601 -p linux/amd64,linux/arm64"
  exit 1
fi

# Check if the Dockerfile directory exists
if [ ! -d "$DOCKERFILE_DIR" ]; then
  echo "Error: Dockerfile directory '$DOCKERFILE_DIR' does not exist"
  exit 1
fi

# Check if Dockerfile exists in the specified directory
if [ ! -f "$DOCKERFILE_DIR/Dockerfile" ]; then
  echo "Error: Dockerfile not found in '$DOCKERFILE_DIR'"
  exit 1
fi

# Parse the comma-separated list of tags
IFS=',' read -ra TAG_ARRAY <<< "$TAGS"
TAG_ARGS=""

echo "Building multi-platform Docker image with tags:"
for tag in "${TAG_ARRAY[@]}"; do
  echo "  - $tag"
  TAG_ARGS="$TAG_ARGS --tag $tag"
done

echo "Dockerfile directory: $DOCKERFILE_DIR"
echo "Platforms: $PLATFORMS"

# Build and push the multi-platform image
echo "Building and pushing image..."
docker buildx build \
  --platform "$PLATFORMS" \
  $TAG_ARGS \
  --file "$DOCKERFILE_DIR/Dockerfile" \
  --push \
  "$DOCKERFILE_DIR"

echo "Successfully built and pushed multi-platform images with tags:"
for tag in "${TAG_ARRAY[@]}"; do
  echo "  - $tag"
done
