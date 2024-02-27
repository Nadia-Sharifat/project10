#!/bin/bash
read -p "Enter container name:  " CONTAINER_NAME

# Step 1: Run the Ubuntu container
CONTAINER_ID=$(docker run -dit --name $CONTAINER_NAME --expose 22 ubuntu)

# Step 2: Install OpenSSH server
docker exec $CONTAINER_ID apt update
docker exec $CONTAINER_ID apt install -y openssh-server

# Step 3: Start SSH service
docker exec $CONTAINER_ID service ssh start

# Step 4: Add user 'nadia' to the '_ssh' group
docker exec $CONTAINER_ID useradd nadia -G _ssh

# Step 5: Retrieve container IP address
CONTAINER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINER_ID)

# step 6: setting password for nadia
docker exec -it $CONTAINER_ID bash -c 'echo "nadia:your_password" | chpasswd'

# Step 9: SSH into the container as 'nadia'
ssh nadia@$CONTAINER_IP

