#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' 

error_exit() {
    echo -e "${RED}Error: $1${NC}" >&2
    exit 1
}
set -e

echo -e "${GREEN}Starting setup of VNC and noVNC on github codespace terminal...${NC}"

# Update and install necessary packages
echo -e "${YELLOW}1. Updating system and installing required packages...${NC}"
{
    sudo apt update
    sudo apt install -y xfce4 xfce4-goodies novnc python3-websockify python3-numpy tightvncserver htop nano neofetch
} || error_exit "Failed to update and install packages."

# Generate SSL certificate
echo -e "${YELLOW}2. Generating SSL certificate for noVNC...${NC}"
{
    mkdir -p ~/.vnc
    openssl req -x509 -nodes -newkey rsa:3072 -keyout ~/.vnc/novnc.pem -out ~/.vnc/novnc.pem -days 3650 -subj "/C=US/ST=State/L=City/O=Organization/OU=OrgUnit/CN=localhost"
} || error_exit "Failed to generate SSL certificate."

# Start VNC server to create initial configuration files
echo -e "${YELLOW}3. Starting VNC server to create initial configuration files...${NC}"
{
    vncserver
} || error_exit "Failed to start VNC server."

# Kill the VNC server to edit the configuration
echo -e "${YELLOW}4. Stopping VNC server to modify configuration files...${NC}"
{
    vncserver -kill :1
} || error_exit "Failed to kill VNC server."

# Backup and create new xstartup file
echo -e "${YELLOW}5. Backing up old xstartup file and creating a new one...${NC}"
{
    mv ~/.vnc/xstartup ~/.vnc/xstartup.bak

    cat <<EOL > ~/.vnc/xstartup
#!/bin/sh
xrdb \$HOME/.Xresources
startxfce4 &
EOL

    chmod +x ~/.vnc/xstartup
} || error_exit "Failed to back up and create xstartup file."

echo -e "${GREEN}Succesfully configured please run ${YELLOW}start-novcn.sh${NC}"