#!/bin/bash

# Install Git and neccesery tools
echo "Installing Git and nodejs"
sudo yum update -y
sudo yum install git -y
sudo yum install npm -y 
sudo yum install maven -y

# Clone website code
echo "Cloning website"
sudo mkdir -p /demo-website
cd /demo-website
sudo git clone https://github.com/omer5574/colman-cloud-final-project.git .

# Install dependencies
echo "Installing dependencies"
sudo npm install
#Install dotenv for read env variables from .env file
sudo npm install dotenv

#Create .env file with env variables for DB connection for example:
#DB_HOST="Enter RDS endpoint here"
#DB_USER="Enter RDS username here"
#DB_PASSWORD="Enter RDS password here"
#DB_NAME="Enter RDS database name here"

# Install & use pm2 to run Node app in background
echo "Installing & starting pm2"

sudo npm install pm2@latest -g
pm2 start app.js

# Save pm2 process list and restart on reboot (e.g. after instance crash) 
pm2 startup
sudo env PATH=$PATH:/usr/bin /usr/local/lib/node_modules/pm2/bin/pm2 startup systemd -u ec2-user --hp /home/ec2-user