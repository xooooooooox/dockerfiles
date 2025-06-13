# Dockerfiles

This repository contains Dockerfiles for various base images.

## CI/CD Workflows

This repository includes CI/CD workflows for both GitHub Actions and GitLab CI that automatically build and push Docker images to DockerHub when Dockerfiles are changed.

### Common Features

- Automatically runs daily at midnight UTC
- Can be manually triggered
- Detects which Dockerfiles have changed and only builds those
- Supports multiple Dockerfiles in different directories
- Builds multi-platform images (AMD64 and ARM64 by default)
- Pushes images with both `latest` and date-based tags (format: `yyyyMMdd`)

## GitHub Actions Workflow

### Required Secrets

To use the GitHub Actions workflow, you need to set up the following secrets in your GitHub repository:

- `DOCKERHUB_USERNAME` - Your DockerHub username
- `DOCKERHUB_TOKEN` - Your DockerHub access token (not your password)

### How to Set Up Secrets in GitHub

1. Go to your GitHub repository
2. Click on "Settings" > "Secrets and variables" > "Actions"
3. Click "New repository secret"
4. Add the required secrets

### Manual Triggering in GitHub

To manually trigger the GitHub workflow:

1. Go to the "Actions" tab in your GitHub repository
2. Select the "Docker Build and Push" workflow
3. Click "Run workflow"
4. Optionally specify a specific Dockerfile directory to build
5. Click "Run workflow"

## GitLab CI Workflow

### Required Variables

To use the GitLab CI workflow, you need to set up the following CI/CD variables in your GitLab project:

- `DOCKERHUB_USERNAME` - Your DockerHub username
- `DOCKERHUB_TOKEN` - Your DockerHub access token (not your password)

### How to Set Up Variables in GitLab

1. Go to your GitLab project
2. Click on "Settings" > "CI/CD"
3. Expand the "Variables" section
4. Click "Add variable"
5. Add the required variables (mark DOCKERHUB_TOKEN as "Masked" for security)

### Schedule Setup in GitLab

To set up the daily schedule:

1. Go to your GitLab project
2. Click on "CI/CD" > "Schedules"
3. Click "New schedule"
4. Set "Interval pattern" to "0 0 * * *" (runs at 00:00 UTC every day)
5. Set "Timezone" to "UTC"
6. Save the schedule

### Manual Triggering in GitLab

To manually trigger the GitLab CI pipeline:

1. Go to your GitLab project
2. Click on "CI/CD" > "Pipelines"
3. Click "Run pipeline"
4. To build a specific Dockerfile, add a variable with key "SPECIFIC_DOCKERFILE" and value set to the directory containing the Dockerfile
5. Click "Run pipeline"

## Build and Push Script

A script is provided to build multi-platform Docker images and push them to a registry.

### Usage

```bash
./build-push.sh -d <dockerfile_dir> -t <tag1,tag2,...> [-p <platforms>]
```

### Parameters

- `-d` - Directory containing the Dockerfile (required)
- `-t` - Comma-separated list of full image names including registry and tags (e.g., username/imagename:latest,username/imagename:20240601) (required)
- `-p` - Platforms to build for (optional, default: linux/amd64,linux/arm64)

### Example

Build and push the Alpine image to DockerHub with multiple tags:

```bash
# Login to DockerHub first
docker login

# Build and push the Alpine image with both latest and date-based tags
./build-push.sh -d alpine -t yourusername/alpine:latest,yourusername/alpine:20240601
```

This will build the Alpine image for both AMD64 and ARM64 architectures and push it to DockerHub with two tags: `latest` and `20240601`.
