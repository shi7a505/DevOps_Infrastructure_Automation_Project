#!/bin/bash
set -e

# Update system
sudo apt-get update
sudo apt-get upgrade -y

# Install Java 11
sudo apt-get install -y openjdk-11-jdk

# Install Tomcat 9
sudo apt-get install -y tomcat9 tomcat9-admin

# Configure Tomcat users
sudo tee /etc/tomcat9/tomcat-users.xml > /dev/null << 'TOMCAT'
<?xml version="1.0" encoding="UTF-8"?>
<tomcat-users xmlns="http://tomcat.apache.org/xml"
              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd"
              version="1.0">
  <role rolename="manager-gui"/>
  <role rolename="manager-script"/>
  <role rolename="manager-jmx"/>
  <role rolename="manager-status"/>
  <user username="admin" password="admin123" roles="manager-gui,manager-script,manager-jmx,manager-status"/>
</tomcat-users>
TOMCAT

# Allow remote access to manager app
sudo sed -i 's/<Valve className="org.apache.catalina.valves.RemoteAddrValve"/<!--Valve className="org.apache.catalina.valves.RemoteAddrValve"/g' /usr/share/tomcat9-admin/manager/META-INF/context.xml
sudo sed -i 's/allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" \/>/allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" \/-->/g' /usr/share/tomcat9-admin/manager/META-INF/context.xml

# Restart Tomcat
sudo systemctl restart tomcat9
sudo systemctl enable tomcat9

# Install Git
sudo apt-get install -y git

# Create completion marker
echo "Application Server setup completed at $(date)" | sudo tee /home/ubuntu/app-server-setup-complete.txt

echo "Tomcat is ready!"
echo "Manager App: http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4):8080/manager"
echo "Credentials: admin / admin123"
