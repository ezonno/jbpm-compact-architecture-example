#!/bin/bash

echo "🚀 Setting up jBPM development environment..."

# Install additional dependencies if needed
echo "📦 Installing dependencies..."
mvn dependency:go-offline -B

# Make scripts executable
chmod +x /workspace/docker-compose/startServices.sh

# Create Maven settings directory if it doesn't exist
mkdir -p ~/.m2

# Make update-urls.sh executable
chmod +x /workspace/.devcontainer/update-urls.sh

# Display helpful information
echo ""
echo "✅ Development environment setup complete!"
echo ""
echo "📋 Quick start commands:"
echo "  - Build project: mvn clean package"
echo "  - Run in dev mode: mvn quarkus:dev"
echo "  - Start services: cd docker-compose && ./startServices.sh"
echo ""

# Show appropriate URLs based on environment
/workspace/.devcontainer/update-urls.sh