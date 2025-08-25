#!/usr/bin/env bash
set -e

# Colors
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"

echo -e "\n${BLUE}🛑 Stopping Docker service...${RESET}\n"
if sudo systemctl stop docker 2>/dev/null; then
    echo -e "${GREEN}✅ Docker service stopped!${RESET}\n"
else
    echo -e "${YELLOW}ℹ️ Docker service was not running.${RESET}\n"
fi

echo -e "${BLUE}🗑️ Removing Docker packages...${RESET}\n"
if sudo apt-get purge -y docker.io; then
    echo -e "${GREEN}✅ Docker packages removed successfully!${RESET}\n"
else
    echo -e "${RED}❌ Failed to remove Docker packages.${RESET}\n"
    exit 1
fi

echo -e "${BLUE}🧹 Cleaning up unused dependencies...${RESET}\n"
if sudo apt-get autoremove -y && sudo apt-get autoclean -y; then
    echo -e "${GREEN}✅ System cleaned up!${RESET}\n"
else
    echo -e "${YELLOW}⚠️ Cleanup skipped.${RESET}\n"
fi

echo -e "${BLUE}🗂️ Removing Docker directories...${RESET}\n"
if sudo rm -rf /var/lib/docker /etc/docker /var/run/docker.sock; then
    echo -e "${GREEN}✅ Docker directories removed!${RESET}\n"
else
    echo -e "${YELLOW}⚠️ Some Docker directories could not be removed.${RESET}\n"
fi

echo -e "${BLUE}📄 Checking .bashrc for Docker socket fix...${RESET}\n"
BASHRC="$HOME/.bashrc"
DOCKER_SOCK_FIX="sudo chown \$USER:\$USER /var/run/docker.sock"

if grep -Fxq "$DOCKER_SOCK_FIX" "$BASHRC"; then
    sed -i "\|$DOCKER_SOCK_FIX|d" "$BASHRC"
    echo -e "${GREEN}✅ Removed Docker socket fix from .bashrc${RESET}\n"
else
    echo -e "${YELLOW}ℹ️ No Docker socket fix found in .bashrc${RESET}\n"
fi

echo -e "${BLUE}🔍 Verifying Docker uninstallation...${RESET}\n"
if command -v docker >/dev/null 2>&1; then
    echo -e "${RED}❌ Docker command still exists. Please reboot or check manually.${RESET}\n"
    exit 1
else
    echo -e "${GREEN}✅ Docker successfully uninstalled!${RESET}\n"
fi

echo -e "\n${GREEN}🎉 Docker removal complete! 🚀${RESET}\n"

