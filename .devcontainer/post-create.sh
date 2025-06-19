#!/bin/bash

# echo "Installing java"
# sdk default java 17.0.9-ms

echo "🚀 Setting up jBPM development environment..."

# Install additional dependencies if needed
echo "📦 Installing dependencies..."
mvn dependency:go-offline -B

# Make scripts executable
chmod +x /workspace/docker-compose/startServices.sh
chmod +x /workspace/.devcontainer/start-services.sh
chmod +x /workspace/.devcontainer/stop-services.sh
chmod +x /workspace/.devcontainer/update-urls.sh

# Create Maven settings directory if it doesn't exist
mkdir -p ~/.m2

# Display helpful information
echo ""
echo "✅ Development environment setup complete!"
echo ""
echo "📋 Quick start commands:"
echo "  - Build project: mvn clean package"
echo "  - Run in dev mode: mvn quarkus:dev"
echo "  - Start all services: /workspace/.devcontainer/start-services.sh"
echo "  - Or start services manually: cd docker-compose && ./startServices.sh"
echo ""
echo "⚠️  Note: The additional services (PostgreSQL, Keycloak, etc.) are not started automatically."
echo "    Run '/workspace/.devcontainer/start-services.sh' to start them when needed."