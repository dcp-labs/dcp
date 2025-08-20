#!/bin/bash

set -e

ARCH=$(uname -m)

# Choose the correct AWS CLI download URL
if [ "$ARCH" = "x86_64" ]; then
    AWS_CLI_URL="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
elif [ "$ARCH" = "aarch64" ]; then
    AWS_CLI_URL="https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip"
else
    echo "❌ Unsupported architecture: $ARCH"
    exit 1
fi

echo "📦 Downloading AWS CLI for architecture: $ARCH"

# Try downloading with curl (with SSL check), fallback to -k if it fails
if ! curl -fsSL "$AWS_CLI_URL" -o awscliv2.zip; then
    echo "⚠️  SSL verification failed. Retrying with --insecure (-k)..."
    if ! curl -k -fsSL "$AWS_CLI_URL" -o awscliv2.zip; then
        echo "❌ Failed to download AWS CLI installer. Please check your internet connection or SSL certificates."
        exit 1
    fi
fi

echo "📂 Unzipping installer..."
unzip -q awscliv2.zip

echo "⚙️ Installing AWS CLI..."
sudo ./aws/install

echo "🧹 Cleaning up..."
rm -rf aws awscliv2.zip

# Display version info nicely
echo
echo "✅ AWS CLI Installed Successfully!"
echo
aws_version=$(aws --version 2>&1)
echo "🔧 Version Info:"
echo "   $aws_version"
echo
