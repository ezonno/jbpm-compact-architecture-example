#!/bin/bash
# Set environment variables for Docker Compose

export BROWSER_HOST=localhost
export REGISTRY_PREFIX=quay.io/kiegroup
export PROJECT_VERSION=1.0.0-SNAPSHOT
export KOGITO_MANAGEMENT_CONSOLE_IMAGE=docker.io/apache/incubator-kie-kogito-management-console:10.0.0
export KOGITO_TASK_CONSOLE_IMAGE=docker.io/apache/incubator-kie-kogito-task-console:10.0.0

echo "Environment variables set:"
echo "BROWSER_HOST=$BROWSER_HOST"
echo "REGISTRY_PREFIX=$REGISTRY_PREFIX"
echo "PROJECT_VERSION=$PROJECT_VERSION"