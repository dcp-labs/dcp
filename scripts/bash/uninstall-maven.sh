#!/usr/bin/env bash
set -e

# Colors
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"

echo -e "\n${BLUE}🗑️ Removing Maven package...${RESET}\n"
if sudo apt-get purge -y maven; then
    echo -e "${GREEN}✅ Maven package removed!${RESET}\n"
else
    echo -e "${RED}❌ Failed to remove Maven package.${RESET}\n"
    exit 1
fi

echo -e "${BLUE}🧹 Cleaning up unused dependencies...${RESET}\n"
if sudo apt-get autoremove -y && sudo apt-get autoclean -y; then
    echo -e "${GREEN}✅ Cleanup completed!${RESET}\n"
else
    echo -e "${YELLOW}⚠️ Cleanup step had issues, but continuing...${RESET}\n"
fi

echo -e "\n${GREEN}🎉 Maven has been completely uninstalled from your system! 🚀${RESET}\n"
