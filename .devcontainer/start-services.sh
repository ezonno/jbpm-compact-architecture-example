#!/bin/bash

echo "🚀 Starting jBPM services..."

# Set environment variables
export REGISTRY_PREFIX=quay.io/kiegroup
export PROJECT_VERSION=1.0.0-SNAPSHOT
export KOGITO_MANAGEMENT_CONSOLE_IMAGE=docker.io/apache/incubator-kie-kogito-management-console:10.0.0
export KOGITO_TASK_CONSOLE_IMAGE=docker.io/apache/incubator-kie-kogito-task-console:10.0.0

# Navigate to docker-compose directory
cd /workspace/docker-compose

# Determine if we're in Codespaces
if [ -n "$CODESPACES" ]; then
    echo "🌐 Running in GitHub Codespaces - using Codespaces configuration..."
    COMPOSE_FILES="-f docker-compose.yml -f /workspace/.devcontainer/docker-compose.codespaces.yml"
else
    echo "🖥️  Running locally..."
    COMPOSE_FILES="-f docker-compose.yml"
fi

# Start the services
echo "📦 Starting infrastructure services..."
docker compose $COMPOSE_FILES up -d postgres pgadmin

echo "⏳ Waiting for PostgreSQL to be ready..."
until docker compose $COMPOSE_FILES exec -T postgres pg_isready -U postgres; do
  sleep 2
done

echo "🏗️ Building and starting application service..."
# First build the application if needed
if [ ! -f "/workspace/target/quarkus-app/quarkus-run.jar" ]; then
    echo "📦 Building application..."
    cd /workspace
    mvn clean package -DskipTests
    cd /workspace/docker-compose
fi

# For Codespaces, we'll run the app directly instead of in a container
if [ -n "$CODESPACES" ]; then
    echo "🚀 Starting application in development mode..."
    cd /workspace
    mvn quarkus:dev -Dquarkus.http.host=0.0.0.0 &
    QUARKUS_PID=$!
    echo "Application started with PID: $QUARKUS_PID"
    cd /workspace/docker-compose
else
    docker compose $COMPOSE_FILES up -d jbpm-compact-architecture-example-service
fi

echo "🔐 Starting Keycloak..."
docker compose $COMPOSE_FILES up -d keycloak

echo "⏳ Waiting for Keycloak to be ready..."
until curl -f http://localhost:8480/auth/realms/kogito >/dev/null 2>&1; do
  sleep 2
done

echo "🖥️ Starting consoles..."
docker compose $COMPOSE_FILES up -d management-console task-console

echo ""
echo "✅ All services started!"
echo ""

# Show the URLs
/workspace/.devcontainer/update-urls.sh

# Show running services
echo ""
echo "📊 Running services:"
docker compose $COMPOSE_FILES ps