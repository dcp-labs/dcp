#!/bin/bash

set -e

echo "🧹 AWS CLI Uninstaller"

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "⚠️  AWS CLI is not installed on this system."
    exit 0
fi

AWS_PATH=$(command -v aws)
echo "⚠️  Found AWS CLI installation at: $AWS_PATH"

# Detect main install directory (default is /usr/local/aws-cli)
if [ -d "/usr/local/aws-cli" ]; then
    INSTALL_DIR="/usr/local/aws-cli"
elif [ -d "/usr/bin/aws-cli" ]; then
    INSTALL_DIR="/usr/bin/aws-cli"
else
    INSTALL_DIR=$(dirname "$AWS_PATH")
fi

echo "📂 Removing AWS CLI from: $INSTALL_DIR"

# Run bundled uninstaller if it exists
if [ -x "$INSTALL_DIR/v2/current/dist/aws_uninstall" ]; then
    sudo "$INSTALL_DIR/v2/current/dist/aws_uninstall"
elif [ -x "$INSTALL_DIR/v2/current/dist/uninstall" ]; then
    sudo "$INSTALL_DIR/v2/current/dist/uninstall"
else
    echo "⚠️  No built-in uninstaller found. Removing manually..."
    sudo rm -rf "$INSTALL_DIR"
    sudo rm -f /usr/local/bin/aws /usr/local/bin/aws_completer
fi

echo "✅ AWS CLI has been removed."

# Verify removal
if command -v aws &> /dev/null; then
    echo "❌ Uninstall failed. AWS CLI still present at $(command -v aws)"
    exit 1
else
    echo "🧹 Cleanup complete. AWS CLI is no longer installed."
fi
