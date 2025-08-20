#!/usr/bin/env bash
set -e

# Colors
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"

echo -e "\n${BLUE}🛑 Stopping Jenkins service (if present)...${RESET}\n"
if systemctl list-unit-files --type=service | grep -q '^jenkins.service'; then
	if sudo systemctl stop jenkins; then
		echo -e "${GREEN}✅ Jenkins service stopped.${RESET}"
	else
		echo -e "${YELLOW}⚠️ Could not stop Jenkins (it may not be running).${RESET}"
	fi
	if sudo systemctl disable jenkins; then
		echo -e "${GREEN}✅ Jenkins service disabled.${RESET}"
	else
		echo -e "${YELLOW}⚠️ Could not disable Jenkins (it may already be disabled).${RESET}"
	fi
	sudo systemctl daemon-reload || true
else
	echo -e "${YELLOW}ℹ️ Jenkins service not found.${RESET}"
fi

echo -e "\n${BLUE}🧹 Purging Jenkins package...${RESET}\n"
if dpkg -s jenkins >/dev/null 2>&1; then
	if sudo apt-get purge -y jenkins; then
		echo -e "${GREEN}✅ Jenkins package purged.${RESET}"
	else
		echo -e "${RED}❌ Failed to purge Jenkins package.${RESET}"
		exit 1
	fi
else
	echo -e "${YELLOW}ℹ️ Jenkins package not installed or already removed.${RESET}"
fi

echo -e "\n${BLUE}🗑️ Removing Jenkins APT repository and key...${RESET}"
if [ -f /etc/apt/sources.list.d/jenkins.list ]; then
	if sudo rm -f /etc/apt/sources.list.d/jenkins.list; then
		echo -e "${GREEN}✅ Removed Jenkins repo list.${RESET}"
	else
		echo -e "${RED}❌ Failed to remove Jenkins repo list.${RESET}"
		exit 1
	fi
else
	echo -e "${YELLOW}ℹ️ Jenkins repo list not found.${RESET}"
fi

if [ -f /etc/apt/keyrings/jenkins-keyring.asc ]; then
	if sudo rm -f /etc/apt/keyrings/jenkins-keyring.asc; then
		echo -e "${GREEN}✅ Removed Jenkins keyring.${RESET}"
	else
		echo -e "${RED}❌ Failed to remove Jenkins keyring.${RESET}"
		exit 1
	fi
else
	echo -e "${YELLOW}ℹ️ Jenkins keyring not found.${RESET}"
fi

echo -e "\n${BLUE}🔄 Updating package lists...${RESET}\n"
if sudo apt-get update -y; then
	echo -e "${GREEN}✅ Package lists updated.${RESET}\n"
else
	echo -e "${RED}❌ Failed to update package lists.${RESET}\n"
	exit 1
fi

echo -e "${BLUE}🧽 Cleaning up dependencies and cache...${RESET}"
sudo apt-get autoremove --purge -y || true
sudo apt-get autoclean -y || true

echo -e "\n${BLUE}🗄️ Removing Jenkins directories and config files...${RESET}"
for path in \
	/var/lib/jenkins \
	/var/log/jenkins \
	/var/cache/jenkins \
	/etc/jenkins \
	/etc/default/jenkins; do
	if [ -e "$path" ]; then
		if sudo rm -rf "$path"; then
			echo -e "${GREEN}✅ Removed ${path}.${RESET}"
		else
			echo -e "${YELLOW}⚠️ Could not remove ${path}.${RESET}"
		fi
	fi
done

echo -e "\n${BLUE}👤 Removing Jenkins user and group (if present)...${RESET}"
if id -u jenkins >/dev/null 2>&1; then
	if sudo deluser --remove-home jenkins >/dev/null 2>&1 || sudo userdel jenkins >/dev/null 2>&1; then
		echo -e "${GREEN}✅ Removed user 'jenkins'.${RESET}"
	else
		echo -e "${YELLOW}⚠️ Could not remove user 'jenkins' (may be in use).${RESET}"
	fi
else
	echo -e "${YELLOW}ℹ️ User 'jenkins' not found.${RESET}"
fi

if getent group jenkins >/dev/null 2>&1; then
	if sudo delgroup jenkins >/dev/null 2>&1 || sudo groupdel jenkins >/dev/null 2>&1; then
		echo -e "${GREEN}✅ Removed group 'jenkins'.${RESET}"
	else
		echo -e "${YELLOW}⚠️ Could not remove group 'jenkins'.${RESET}"
	fi
else
	echo -e "${YELLOW}ℹ️ Group 'jenkins' not found.${RESET}"
fi

echo -e "\n${GREEN}🎉 Jenkins has been completely removed from this system.${RESET}\n"


