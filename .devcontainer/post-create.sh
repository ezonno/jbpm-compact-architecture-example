#!/bin/bash

echo "🚀 Setting up jBPM development environment..."

# Install additional dependencies if needed
echo "📦 Installing dependencies..."
mvn dependency:go-offline -B

# Make scripts executable
chmod +x /workspace/docker-compose/startServices.sh

# Create Maven settings directory if it doesn't exist
mkdir -p ~/.m2

# Display helpful information
echo ""
echo "✅ Development environment setup complete!"
echo ""
echo "📋 Quick start commands:"
echo "  - Build project: mvn clean package"
echo "  - Run in dev mode: mvn quarkus:dev"
echo "  - Start services: cd docker-compose && ./startServices.sh"
echo ""
echo "🌐 Service URLs (when running):"
echo "  - Application: http://localhost:8080"
echo "  - Management Console: http://localhost:8280"
echo "  - Task Console: http://localhost:8380"
echo "  - Keycloak: http://localhost:8480"
echo "  - pgAdmin: http://localhost:8055"
echo ""