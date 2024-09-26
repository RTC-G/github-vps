#!/bin/bash

NC="\e[0m"        
RED="\033[0;31m"      
GREEN="\033[0;32m"    
YELLOW="\033[1;33m"   
BLUE="\033[1;34m"     
CYAN="\033[1;36m"     
WHITE="\033[1;37m"    
MAGENTA="\033[1;35m"  

WEB_DIR="/usr/share/novnc/"
CERT_FILE="$HOME/.vnc/novnc.pem"
LOCAL_PORT="5901"
LISTEN_PORT="6080"


# Check if the cert file exists
if [ ! -f "$CERT_FILE" ]; then
    echo -e "${RED}Error: Certificate file not found: ${BLINK}$CERT_FILE${NC}"
    exit 1
fi

# Start noVNC
echo -e "${YELLOW} Starting noVNC to enable web-based VNC access...${NC}"
websockify -D --web="$WEB_DIR" --cert="$CERT_FILE" $LISTEN_PORT localhost:$LOCAL_PORT

# Start vncserver
# Note: adjust the resolution if applicable
echo -e "${YELLOW} Starting novncserver${NC}"
vncserver -geometry 1920x1080

echo -e "${GREEN}noVNC server started on port ${WHITE}$LISTEN_PORT${WHITE}, forwarding to localhost:${WHITE}$LOCAL_PORT${NC}"
