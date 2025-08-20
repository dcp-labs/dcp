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

echo -e "${BLUE}☕ Installing Java 21 (OpenJDK)...${RESET}\n"
if sudo apt-get install -y openjdk-21-jdk; then
    echo -e "${GREEN}✅ Java 21 installed successfully!${RESET}\n"
else
    echo -e "${RED}❌ Failed to install Java 21.${RESET}\n"
    exit 1
fi

echo -e "${YELLOW}🔍 Checking Java version...${RESET}\n"
if java -version; then
    echo -e "\n${GREEN}🎉 Installation complete! Java 21 is ready to use! 🚀${RESET}\n"
else
    echo -e "\n${RED}❌ Java installation failed — please check logs.${RESET}\n"
    exit 1
fi
