#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Checking Kali-linux docker ID
kali_id=$(docker ps -a -q)
bash='/bin/bash'

echo -e '${YELLOW}Starting another terminal kali privs${NC}'
docker start $kali_id
docker exec -it $kali_id $bash
echo -e "${YELLOW}Success..${NC}"
sleep 1.5