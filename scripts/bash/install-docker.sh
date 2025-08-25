#!/usr/bin/env bash
set -e

# Colors
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"

echo -e "\n${BLUE}🔄 Updating system packages...${RESET}\n"
if sudo apt-get update -y; then
    echo -e "${GREEN}✅ System updated successfully!${RESET}\n"
else
    echo -e "${RED}❌ Failed to update system packages.${RESET}\n"
    exit 1
fi

echo -e "${BLUE}🐳 Installing Docker (docker.io)...${RESET}\n"
if sudo apt-get install -y docker.io; then
    echo -e "${GREEN}✅ Docker installed successfully!${RESET}\n"
else
    echo -e "${RED}❌ Failed to install Docker.${RESET}\n"
    exit 1
fi

echo -e "${YELLOW}⏳ Waiting 5 seconds before starting Docker...${RESET}\n"
sleep 5

echo -e "${BLUE}🚀 Starting Docker service...${RESET}\n"
if sudo systemctl start docker && sudo systemctl enable docker; then
    echo -e "${GREEN}✅ Docker service start command issued!${RESET}\n"
else
    echo -e "${RED}❌ Failed to issue Docker start command.${RESET}\n"
fi

# Verify if Docker is running, else attempt recovery (3 attempts with 10s sleep)
MAX_ATTEMPTS=3
ATTEMPT=1

while ! systemctl is-active --quiet docker && [ $ATTEMPT -le $MAX_ATTEMPTS ]; do
    echo -e "${YELLOW}⚠️ Docker is not running. Attempt $ATTEMPT of $MAX_ATTEMPTS...${RESET}\n"

    if [ $ATTEMPT -eq 1 ]; then
        echo -e "${BLUE}👉 Trying 'systemctl start docker'...${RESET}\n"
        sudo systemctl start docker || true
    else
        echo -e "${BLUE}👉 Trying 'systemctl restart docker'...${RESET}\n"
        sudo systemctl daemon-reexec
        sudo systemctl daemon-reload
        sudo systemctl stop docker 
        sudo systemctl restart docker || true
    fi

    echo -e "${YELLOW}⏳ Waiting 40 seconds before re-checking...${RESET}\n"
    sleep 40

    if systemctl is-active --quiet docker; then
        echo -e "${GREEN}✅ Docker started successfully on attempt $ATTEMPT!${RESET}\n"
        break
    fi

    ATTEMPT=$((ATTEMPT + 1))
done

if ! systemctl is-active --quiet docker; then
    echo -e "${RED}❌ Docker failed to start after $MAX_ATTEMPTS attempts.${RESET}\n"
    sudo systemctl status docker --no-pager
    exit 1
fi

echo -e "${BLUE}🔧 Applying Docker socket permission fix...${RESET}\n"
if sudo chown "$USER:$USER" /var/run/docker.sock; then
    echo -e "${GREEN}✅ Applied Docker socket permission fix!${RESET}\n"
else
    echo -e "${RED}❌ Failed to apply Docker socket permission fix.${RESET}\n"
    exit 1
fi

echo -e "${BLUE}📄 Checking .bashrc for persistence...${RESET}\n"
BASHRC="$HOME/.bashrc"
DOCKER_SOCK_FIX="sudo chown \$USER:\$USER /var/run/docker.sock"

if grep -Fxq "$DOCKER_SOCK_FIX" "$BASHRC"; then
    echo -e "${YELLOW}ℹ️ Docker socket fix already exists in .bashrc${RESET}\n"
else
    echo "$DOCKER_SOCK_FIX" >> "$BASHRC"
    echo -e "${GREEN}✅ Added Docker socket fix to .bashrc${RESET}\n"
fi

echo -e "${BLUE}🐋 Verifying Docker installation...${RESET}\n"
if docker --version >/dev/null 2>&1; then
    VERSION=$(docker --version)
    echo -e "${GREEN}✅ Docker is working correctly!${RESET}\n"
    echo -e "${BLUE}📦 Installed Docker Version:${RESET} ${YELLOW}$VERSION${RESET}\n"
else
    echo -e "${RED}❌ Docker command is not working. Try restarting your shell or system.${RESET}\n"
    exit 1
fi

echo -e "\n${GREEN}🎉 Docker setup complete! 🚀${RESET}\n"
