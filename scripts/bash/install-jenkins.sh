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

echo -e "${BLUE}📥 Preparing Jenkins repository...${RESET}\n"
if sudo mkdir -p /etc/apt/keyrings && sudo chmod 755 /etc/apt/keyrings; then
	echo -e "${GREEN}✅ Keyring directory ready.${RESET}"
else
	echo -e "${RED}❌ Failed to prepare keyring directory.${RESET}"
	exit 1
fi

echo -e "${BLUE}🔑 Adding Jenkins GPG key...${RESET}"
if sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key; then
	echo -e "${GREEN}✅ Jenkins GPG key added.${RESET}"
else
	echo -e "${RED}❌ Failed to download Jenkins GPG key.${RESET}"
	exit 1
fi

echo -e "${BLUE}🧩 Adding Jenkins APT repository...${RESET}"
if echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null; then
	echo -e "${GREEN}✅ Jenkins repository added.${RESET}\n"
else
	echo -e "${RED}❌ Failed to add Jenkins repository.${RESET}\n"
	exit 1
fi

echo -e "${BLUE}🔄 Updating package list (Jenkins repo)...${RESET}\n"
if sudo apt-get update -y; then
	echo -e "${GREEN}✅ Package list updated.${RESET}\n"
else
	echo -e "${RED}❌ Failed to update package list after adding Jenkins repo.${RESET}\n"
	exit 1
fi

echo -e "${BLUE}📦 Installing Jenkins...${RESET}\n"
if sudo apt-get install -y jenkins; then
	echo -e "${GREEN}✅ Jenkins installed successfully!${RESET}\n"
else
	echo -e "${RED}❌ Failed to install Jenkins.${RESET}\n"
	exit 1
fi

echo -e "${BLUE}🚀 Enabling and starting Jenkins service...${RESET}\n"
if sudo systemctl enable jenkins; then
	echo -e "${GREEN}✅ Jenkins service enabled.${RESET}"
else
	echo -e "${RED}❌ Failed to enable Jenkins service.${RESET}\n"
	exit 1
fi

if sudo systemctl start jenkins; then
	echo -e "${GREEN}✅ Jenkins service started.${RESET}\n"
else
	echo -e "${RED}❌ Failed to start Jenkins service.${RESET}\n"
	exit 1
fi

echo -e "${GREEN}🎉 All done!${RESET}\n"

# Show initial admin password
echo -e "${BLUE}🔎 Reading initial admin password...${RESET}"
echo -e "${YELLOW}⏳ Waiting 10 seconds for Jenkins to initialize...${RESET}"
sleep 10

echo -e "\n${GREEN}═══════════════════════════════════════════════════════════════${RESET}"
echo -e "${GREEN}🔐 JENKINS INITIAL ADMIN PASSWORD${RESET}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════════${RESET}"
echo -e "${YELLOW}📋 Copy the password below to unlock Jenkins:${RESET}\n"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo -e "\n${GREEN}═══════════════════════════════════════════════════════════════${RESET}"
echo -e "${BLUE}🌐 Access Jenkins at: http://localhost:8080${RESET}"
echo -e "${BLUE}📝 Use the password above to complete setup${RESET}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════════${RESET}\n"

echo -e "${GREEN}🎉 Jenkins installation completed successfully!${RESET}"
echo -e "${YELLOW}💡 Next steps:${RESET}"
echo -e "${YELLOW}   1. Open http://localhost:8080 in your browser${RESET}"
echo -e "${YELLOW}   2. Enter the password shown above${RESET}"
echo -e "${YELLOW}   3. Follow the setup wizard to configure Jenkins${RESET}\n"
echo -e "${GREEN}🚀 Happy building!${RESET}\n"
