#!/bin/bash

echo "🛑 Stopping jBPM services..."

cd /workspace/docker-compose

# Determine if we're in Codespaces
if [ -n "$CODESPACES" ]; then
    COMPOSE_FILES="-f docker-compose.yml -f /workspace/.devcontainer/docker-compose.codespaces.yml"
    
    # Stop the Quarkus dev mode if running
    echo "Stopping Quarkus application..."
    pkill -f "mvn quarkus:dev" || true
else
    COMPOSE_FILES="-f docker-compose.yml"
fi

# Stop all services
docker compose $COMPOSE_FILES down

echo "✅ All services stopped!"