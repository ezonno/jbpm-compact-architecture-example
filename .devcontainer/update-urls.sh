#!/bin/bash

# Script to update URLs for GitHub Codespaces or local development

if [ -n "$CODESPACES" ]; then
    echo "🚀 Running in GitHub Codespaces..."
    
    # In Codespaces, the URLs need to be updated to use the forwarded ports
    echo ""
    echo "🌐 Service URLs in Codespaces:"
    echo "  - Application: https://$CODESPACE_NAME-8080.preview.app.github.dev"
    echo "  - Management Console: https://$CODESPACE_NAME-8280.preview.app.github.dev"
    echo "  - Task Console: https://$CODESPACE_NAME-8380.preview.app.github.dev"  
    echo "  - Keycloak: https://$CODESPACE_NAME-8480.preview.app.github.dev"
    echo "  - pgAdmin: https://$CODESPACE_NAME-8055.preview.app.github.dev"
    
    # Update Keycloak URLs for browser access
    export KEYCLOAK_BROWSER_URL="https://$CODESPACE_NAME-8480.preview.app.github.dev/auth"
else
    echo "🖥️  Running locally..."
    echo ""
    echo "🌐 Service URLs (when running):"
    echo "  - Application: http://localhost:8080"
    echo "  - Management Console: http://localhost:8280"
    echo "  - Task Console: http://localhost:8380"
    echo "  - Keycloak: http://localhost:8480"
    echo "  - pgAdmin: http://localhost:8055"
    
    export KEYCLOAK_BROWSER_URL="http://localhost:8480/auth"
fi

echo ""
echo "✅ URLs configured for your environment"