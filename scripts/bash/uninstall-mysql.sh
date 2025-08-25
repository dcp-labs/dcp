#!/usr/bin/env bash
set -e

# Colors
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"

echo -e "\n${BLUE}🗑️ Stopping MySQL service (if running)...${RESET}\n"
if sudo systemctl stop mysql || true; then
    echo -e "${GREEN}✅ MySQL service stopped!${RESET}\n"
else
    echo -e "${YELLOW}⚠️ MySQL service not running or already stopped.${RESET}\n"
fi

echo -e "${BLUE}🧹 Removing MySQL packages...${RESET}\n"
if sudo apt-get purge -y mysql-server mysql-client mysql-common mysql-server-core-* mysql-client-core-*; then
    echo -e "${GREEN}✅ MySQL packages removed!${RESET}\n"
else
    echo -e "${RED}❌ Failed to remove MySQL packages.${RESET}\n"
    exit 1
fi

echo -e "${BLUE}🗑️ Cleaning up dependencies...${RESET}\n"
if sudo apt-get autoremove -y && sudo apt-get autoclean -y; then
    echo -e "${GREEN}✅ Unused dependencies cleaned!${RESET}\n"
else
    echo -e "${YELLOW}⚠️ Cleanup step encountered issues, but continuing...${RESET}\n"
fi

echo -e "${BLUE}📂 Removing MySQL data and configuration files...${RESET}\n"
if sudo rm -rf /etc/mysql /var/lib/mysql /var/log/mysql*; then
    echo -e "${GREEN}✅ MySQL config and data removed!${RESET}\n"
else
    echo -e "${YELLOW}⚠️ Failed to remove some MySQL directories (might not exist).${RESET}\n"
fi

echo -e "\n${GREEN}🎉 MySQL has been completely uninstalled from your system! 🚀${RESET}\n"
