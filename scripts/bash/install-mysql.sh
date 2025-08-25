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

echo -e "${BLUE}🐬 Installing MySQL Server...${RESET}\n"
if sudo apt-get install -y mysql-server; then
    echo -e "${GREEN}✅ MySQL installed successfully!${RESET}\n"
else
    echo -e "${RED}❌ Failed to install MySQL.${RESET}\n"
    exit 1
fi

echo -e "${BLUE}🚀 Starting MySQL service...${RESET}\n"
if sudo systemctl start mysql; then
    echo -e "${GREEN}✅ MySQL service started successfully!${RESET}\n"
else
    echo -e "${RED}❌ Failed to start MySQL service.${RESET}\n"
    exit 1
fi

echo -e "${YELLOW}🔧 Configuring MySQL root user...${RESET}\n"
if sudo mysql -e "DROP USER IF EXISTS 'root'@'localhost';
CREATE USER 'root'@'%' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;"; then
    echo -e "${GREEN}✅ Root user configured successfully!${RESET}\n"
else
    echo -e "${RED}❌ Failed to configure MySQL root user.${RESET}\n"
    exit 1
fi

echo -e "\n${GREEN}🎉 MySQL setup complete! 🚀${RESET}\n"
echo -e "${BLUE}🔑 Use the following credentials to login:${RESET}\n"
echo -e "   Username: ${YELLOW}root${RESET}"
echo -e "   Password: ${YELLOW}1234${RESET}\n"
