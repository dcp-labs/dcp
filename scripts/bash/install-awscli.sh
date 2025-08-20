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

# Function to get latest AWS CLI version from metadata
get_latest_version() {
    curl -fsSL "https://awscli.amazonaws.com/VERSION" 2>/dev/null || echo "0.0.0"
}

# Compare two versions (returns 0 if v1 < v2, else 1)
version_lt() {
    [ "$(printf '%s\n' "$1" "$2" | sort -V | head -n1)" != "$2" ]
}

LATEST_VERSION=$(get_latest_version)

# Check if AWS CLI is already installed
if command -v aws &> /dev/null; then
    INSTALLED_VERSION=$(aws --version 2>&1 | awk '{print $1}' | cut -d/ -f2)
    echo "⚠️  Found AWS CLI installation: version $INSTALLED_VERSION (latest: $LATEST_VERSION)"

    if version_lt "$INSTALLED_VERSION" "$LATEST_VERSION"; then
        echo "⬆️  Updating AWS CLI to $LATEST_VERSION..."
    else
        echo "✅ AWS CLI is already up-to-date."
        echo "🧹 Cleaning up workspace..."
        rm -rf aws awscliv2.zip
        exit 0
    fi
else
    echo "📦 No AWS CLI installation found. Installing version $LATEST_VERSION..."
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
sudo ./aws/install --update

echo "🧹 Cleaning up..."
rm -rf aws awscliv2.zip

# Display version info nicely
echo
echo "✅ AWS CLI Installed/Updated Successfully!"
echo
aws_version=$(aws --version 2>&1)
echo "🔧 Version Info:"
echo "   $aws_version"
