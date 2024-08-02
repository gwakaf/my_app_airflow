#!/bin/bash

# Update the package repository and install necessary packages
yum update -y
yum install -y docker git
yum install -y glibc libxcrypt-compat

# Start the Docker service
systemctl start docker
systemctl enable docker

# Add the ec2-user to the docker group so you can execute Docker commands without sudo
sudo usermod -aG docker ec2-user

# Change docker.sock to new permission
sudo chmod 666 /var/run/docker.sock

# Install Docker Compose
DOCKER_COMPOSE_VERSION="1.29.2"  # Replace with the version you need
curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# You are in a directory /home/ec2-user/

# Download the docker-compose.yaml file from the GitHub repository
GIT_REPO_URL="https://raw.githubusercontent.com/gwakaf/my_app_airflow/main/"  # Replace with your GitHub raw URL
wget "https://raw.githubusercontent.com/gwakaf/my_app_airflow/main/airflow-compose.yaml" -O /airflow-compose.yaml

# sudo curl -O https://raw.githubusercontent.com/gwakaf/https---github.com-gwakaf-my_app_airflow/main/docker-compose.yaml

docker-compose -f airflow-compose.yaml up -d

# Use Docker Compose to build and run the containers
# docker-compose -f /home/ec2-user/docker-compose.yaml up
