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

echo -e "${BLUE}📦 Installing Apache Maven...${RESET}\n"
if sudo apt-get install -y maven; then
    echo -e "${GREEN}✅ Maven installed successfully!${RESET}\n"
else
    echo -e "${RED}❌ Failed to install Maven.${RESET}\n"
    exit 1
fi

echo -e "${YELLOW}🔍 Checking Maven version...${RESET}\n"
if mvn -version; then
    echo -e "\n${GREEN}🎉 Installation complete! Maven is ready to use! 🚀${RESET}\n"
else
    echo -e "\n${RED}❌ Maven installation failed — please check logs.${RESET}\n"
    exit 1
fi
