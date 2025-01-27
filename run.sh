#!/bin/bash
# Colors
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${RED}"
echo -e ' ███╗   ███╗  █████╗        ██╗ ██╗ ██╗  ██╗  █████╗  ██╗  ██╗  █████╗'
echo -e ' ████╗ ████║ ██╔══██╗       ██║ ██║ ██║ ██╔╝ ██╔══██╗ ██║  ██║ ██╔══██║'
echo -e ' ██╔████╔██║ ███████║       ██║ ██║ █████╔╝  ███████║  █████╔╝ ██║  ██║'
echo -e ' ██║╚██╔╝██║ ██╔══██║  ██║  ██║ ██║ ██╔═██╗  ██╔══██║    ██╔╝  ██║  ██║'
echo -e ' ██║ ╚═╝ ██║ ██║  ██║   █████╔╝ ██║ ██║  ██╗ ██║  ██║    ██║    █████╔╝'
echo -e ' ╚═╝     ╚═╝ ╚═╝  ╚═╝   ╚════╝  ╚═╝ ╚═╝  ╚═╝ ╚═╝  ╚═╝    ╚═╝    ╚════╝'
echo -e "${NC}"

echo -e "${BLUE}Join our Telegram channel: https://t.me/NTExhaust${NC}"
echo -e "${RED}-----------------------------------------------------${NC}"
echo -e "${BLUE}Buy VPS 40K on Telegram Store: https://t.me/candrapn${NC}"
sleep 5

# Install necessary dependencies
echo -e "${RED}Installing necessary dependencies...${NC}"
sudo apt update && sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
echo -e "${RED}Adding Docker's official GPG key...${NC}"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add Docker's official repository
echo -e "${RED}Adding Docker's official repository...${NC}"
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update APT package index
echo -e "${RED}Updating APT package index...${NC}"
sudo apt update

# Install Docker
echo -e "${RED}Installing Docker...${NC}"
sudo apt install -y docker-ce

# Start Docker service
echo -e "${RED}Starting Docker service...${NC}"
sudo systemctl start docker

# Enable Docker to start on boot
echo -e "${RED}Enabling Docker to start on boot...${NC}"
sudo systemctl enable docker

# Pull Docker image
echo -e "${RED}Pulling Docker image privasea/acceleration-node-beta:latest...${NC}"
sudo docker pull privasea/acceleration-node-beta:latest

# Create directory and change to /privasea
echo -e "${RED}Creating /privasea/config directory and changing to /privasea...${NC}"
mkdir -p ~/privasea/config && cd ~/privasea

# Run Docker container to create keystore
echo -e "${RED}Running Docker container to create keystore., Copy your Node Addres add to Privase Dasboard${NC}"
docker run --rm -it -v "$HOME/privasea/config:/app/config" privasea/acceleration-node-beta:latest ./node-calc new_keystore

# Check if there is a keystore file in the /privasea/config directory
echo -e "${RED}Renameming New Keystore to wallet_keytore $HOME/privasea/config...${NC}"
mv $HOME/privasea/config/UTC--* $HOME/privasea/config/wallet_keystore


# Prompt user for the keystore password
echo -e "${RED}Please enter the keystore password: ${NC}"
read -s KEYSTORE_PASSWORD

# Run the compute node command with provided password
echo -e "${RED}Running Docker container with KEYSTORE_PASSWORD...${NC}"
docker run  -d   -v "/privasea/config:/app/config" \
  -e KEYSTORE_PASSWORD=$KEYSTORE_PASSWORD \
  privasea/acceleration-node-beta:latest

echo -e "${RED}Process complete. check you docker and dasboard${NC}"
