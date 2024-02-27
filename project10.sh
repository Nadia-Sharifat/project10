#!/bin/bash

# Step 1: Run the Ubuntu container
docker run -dit --name ubuntu1 --expose 22 ubuntu

# Step 2: Install OpenSSH server
docker exec ubuntu10 apt update
docker exec ubuntu10 apt install -y openssh-server

# Step 3: Start SSH service
docker exec ubuntu10 service ssh start

# Step 4: Add user 'nadia' to the '_ssh' group
docker exec ubuntu10 useradd nadia -G _ssh

# Step 5: SSH into the container as root to set nadia's password
read -p "Enter container IP address: " container_ip
ssh root@$container_ip

# Step 6: Set password for 'nadia'
docker exec -it ubuntu10 passwd nadia

# Step 7: Exit from SSH session
exit

# Step 8: SSH into the container as 'nadia'
ssh nadia@$container_ip

