#!/bin/bash

# Step 1: Run the Ubuntu container
container_id=$(docker run -dit --name ubuntu10 --expose 22 ubuntu)

# Step 2: Install OpenSSH server
docker exec $container_id apt update
docker exec $container_id apt install -y openssh-server

# Step 3: Start SSH service
docker exec $container_id service ssh start

# Step 4: Add user 'nadia' to the '_ssh' group
docker exec $container_id useradd nadia -G _ssh

# Step 5: Retrieve container IP address
container_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $container_id)

# Step 6: SSH into the container as root to set nadia's password
ssh root@$container_ip

# Step 7: Set password for 'nadia'
docker exec -it $container_id passwd nadia

# Step 8: Exit from SSH session
exit

# Step 9: SSH into the container as 'nadia'
ssh nadia@$container_ip

